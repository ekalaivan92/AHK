
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Transactions;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;
using Microsoft.VisualBasic;
using System.Drawing;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Forms;

class Program
{
	static void Main(params string[] fileNames)
	{
		var keyTypes = new Dictionary<string, string>();

		keyTypes.Add("Replacers", @"(\:\*\:)");
		keyTypes.Add("Win", @"(#.\:\:)");
		keyTypes.Add("L-Alt", @"(\<\^\>\!)");

		var frm = CreateForm();

		foreach (var type in keyTypes)
		{
			var panel = new Panel { Dock = DockStyle.Top, AutoScroll = true, Height = 250 };
			frm.Controls.Add(panel);

			var keyInfoCollections = GetAllKeyBindings(type.Value);

			var keysCount = (int)Math.Ceiling((decimal)keyInfoCollections.Count / 4);
			var height = (keyInfoCollections.Count > keysCount ? keysCount : keyInfoCollections.Count);
			panel.Height = (height + 1) * 24;

			FillInfo(type.Key, keyInfoCollections, panel, keysCount);
		}

		frm.ShowDialog();
	}

	static void FillInfo
		(string heading, Dictionary<string, string> keyInfoCollections, Control panel, int itemsCount = 5)
	{
		var locationX = 0;
		var locationY = 0;

		var headingLabel = GetNewLable(heading, new System.Drawing.Point(locationX, locationY), 260, ContentAlignment.MiddleCenter);
		headingLabel.BackColor = Color.Green;
		headingLabel.ForeColor = Color.White;
		headingLabel.Dock = DockStyle.Top;
		panel.Controls.Add(headingLabel);

		var startingLocationY = locationY += headingLabel.Height;
		var itemsFilled = 0;

		foreach (var key in keyInfoCollections.Keys.OrderBy(x => x))
		{
			if (itemsFilled != 0 && itemsFilled % itemsCount == 0)
			{
				locationX += 250;
				locationY = startingLocationY;
			}

			var newKeyControl = GetNewLable(key.ToLower(), new System.Drawing.Point(locationX, locationY), 60, ContentAlignment.MiddleRight);
			newKeyControl.Font = new Font(Label.DefaultFont, System.Drawing.FontStyle.Bold);
			var newInfoControl = GetNewLable($": {keyInfoCollections[key]}", new System.Drawing.Point(locationX + 60, locationY), 200, ContentAlignment.MiddleLeft);

			newKeyControl.Tag = newInfoControl;
			newInfoControl.Tag = newKeyControl;

			panel.Controls.Add(newKeyControl);
			panel.Controls.Add(newInfoControl);

			locationY += newKeyControl.Height;
			itemsFilled++;
		}
	}

	static Form CreateForm()
	{
		var frm = new Form() { Height = 580, Width = 1060, MaximizeBox = false, MinimizeBox = false, ShowIcon = false, Text = "AHK Shortcuts" };

		frm.Load += new EventHandler((s, e) =>
		{
			var timer = new System.Windows.Forms.Timer();
			timer.Interval = 5000;
			timer.Tick += new EventHandler((s, e) =>
			{
				if (!frm.Focused) frm.Close();
			});

			timer.Start();
		});

		frm.KeyDown += new KeyEventHandler((s, e) => { if (e.KeyCode == Keys.Escape) frm.Close(); });

		return frm;
	}


	static Dictionary<string, string> GetAllKeyBindings(string bindingPattern)
	{
		var keyInfoCollections = new Dictionary<string, string>();

		var fileNames = new string[2] {
		@"./MyKeys_AllDescktop.ahk",
		@"./MyKeys_DesktopFocused.ahk"
	};

		foreach (var fileName in fileNames)
		{
			var lines = File.ReadAllLines(fileName);
			//To Avoid getting #Include or #If
			var regex = new Regex(bindingPattern, RegexOptions.IgnoreCase);
			//To Avoid removing keys from the windows shortcuts. ex: removing 2 from #2 for vs22
			var regex1 = new Regex(@"(\:\*\:)|(\<\^\>\!)|(#)", RegexOptions.IgnoreCase);
			var keyLines = lines.Where(x => regex.Match(x)?.Success == true);

			var resultLines = keyLines
								.Where(x => !x.Contains("|"))
								.Select(x => regex1.Replace(x, "")
								.Replace("::", "")
								.Split(';'));

			var resultLines1 = keyLines
								.Where(x => x.Contains("|"))
								.Select(x => regex1.Replace(x, "")
								.Replace("::", "")
								.Split(';'));

			//To combine multiple subkeys
			foreach (var item in resultLines1)
			{
				var exKeys = item[1].Split('|');
				foreach (var keyLine in exKeys)
				{
					var x = keyLine.Replace("--", "-");
					var key = x.Split('-');
					resultLines = resultLines.Append(new string[] { $"{item[0]}{key[0]}".Trim(), key[1].Trim() });
				}
			}

			var dict = resultLines
				.ToDictionary(k => k[0],
							  v => v.Length > 1 ? v[1] : v[0])
				.Select(x => x);

			keyInfoCollections = keyInfoCollections
				.Concat(dict)
				.ToDictionary(x => x.Key, v => v.Value);
		}

		return keyInfoCollections;
	}

	static Label GetNewLable(string text, System.Drawing.Point location, int Width, ContentAlignment alignment)
	{
		var label = new Label
		{
			Text = text,
			Location = location,
			Width = Width,
			TextAlign = alignment
		};

		label.MouseEnter += new EventHandler((s, x) => { changeColor(s, Color.LightGray).GetAwaiter(); });
		label.MouseLeave += new EventHandler((s, x) => { changeColor(s, Control.DefaultBackColor).GetAwaiter(); });

		return label;
	}

	static async Task changeColor(object label, Color color)
	{
		await Task.Run(() =>
		{
			var ogLabel = (Label)label;
			var coLabel = (Label)ogLabel.Tag;

			if (coLabel == null)
			{
				return;
			}

			ogLabel.BackColor = coLabel.BackColor = color;
		});
	}
}