Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Crsfx-00037d-9j for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Jan 2005 22:53:45 -0800
Received: from [202.91.196.193] (helo=printsoft.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Crsfw-0006E2-P6 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Jan 2005 22:53:45 -0800
Received: from [192.168.4.162] (unknown [192.168.4.162])
	by printsoft.com (linuxmail) with ESMTP id 95D52308011
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 21 Jan 2005 17:53:35 +1100 (EST)
Message-ID: <41F0A6F3.4030109@printsoft.com>
From: Gerhard Hannemann <gerhard.hannemann@printsoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=======AVGMAIL-41F0A6F35A07======="
Subject: [uml-devel] UML - Is it using swap space?
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 21 Jan 2005 17:53:39 +1100
To: user-mode-linux-devel@lists.sourceforge.net

--=======AVGMAIL-41F0A6F35A07=======
Content-Type: multipart/alternative;
	boundary=------------060305070608070009070808

--------------060305070608070009070808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Why does it seem that my UML does is not using its swap space?
The memory usage drops down to just 1M yet tools such as
top and free never indcate that any swap space is ever being used.
I provide the UML with a 512M swap_fs file and swapon -s
seems to indicate that its available.


Thanks

--------------060305070608070009070808
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<span class="postbody">Why does it seem that my UML does is not using
its swap space?
<br>
The memory usage drops down to just 1M yet tools such as <br>
top and free never indcate that any swap space is ever being used. <br>
I provide the UML with a 512M swap_fs file and <span
 style="font-weight: bold;"><span style="font-style: italic;">swapon -s</span></span>
<br>
seems to indicate that its available.
<br>
<br>
<br>
Thanks </span>
</body>
</html>

--------------060305070608070009070808--

--=======AVGMAIL-41F0A6F35A07=======
Content-Type: text/plain; x-avg=cert; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Description: "AVG certification"

No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.300 / Virus Database: 265.7.1 - Release Date: 19/01/2005

--=======AVGMAIL-41F0A6F35A07=======--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
