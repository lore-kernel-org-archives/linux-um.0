Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrseS-00034u-0b for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Jan 2005 22:52:12 -0800
Received: from [202.91.196.193] (helo=printsoft.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CrseR-0005un-8S for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Jan 2005 22:52:11 -0800
Received: from [192.168.4.162] (unknown [192.168.4.162])
	by printsoft.com (linuxmail) with ESMTP id 6B066308011
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 21 Jan 2005 17:52:03 +1100 (EST)
Message-ID: <41F0A696.8050201@printsoft.com>
From: Gerhard Hannemann <gerhard.hannemann@printsoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=======AVGMAIL-41F0A6975630======="
Subject: [uml-devel] UML - stalling during large file transfers
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
Date: Fri, 21 Jan 2005 17:52:06 +1100
To: user-mode-linux-devel@lists.sourceforge.net

--=======AVGMAIL-41F0A6975630=======
Content-Type: multipart/alternative;
	boundary=------------020607060100020902000300

--------------020607060100020902000300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Encountered a baffling problem while copying large amounts of files from 
a archive (*.tbz) or from a remote system to a directory within a 
running UML system. The UML stalls while the IDE hardrive thrashes along 
for server minutes. It recovers, continues on with some more files, and 
stall again. While this is happening, all maternity's connected to that 
UML just freeze.
The host system is perfectly accessible and on show minimal CPU usages. 
A running top session within the UML also show low CPU and moderate 
memory usage. However the UML's load increases up to 3.x for several 
minutes and then recovers.
System Data:

      Host:
      AMD Athlon 2.1Ghz running Gentoo using 2.6.9 kernel with skas3 patch.
      1 SCSI 18G drive (boot drive) and one IDE 15G drive.
      1G tmpfs
      UML:
      Vanilla 2.4.27 UML kernel (patched of UML usage)
      3G file system and 512M swap.
      The UML is run using 512M of mem.
      The UML runs from the IDE drive. 


Thanks


--------------020607060100020902000300
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<span class="postbody">Encountered a baffling problem while copying
large amounts of files from a archive (*.tbz) or from a remote system
to a directory within a running UML system. The UML stalls while the
IDE hardrive thrashes along for server minutes. It recovers, continues
on with some more files, and stall again. While this is happening, all
maternity's connected to that UML just freeze. <br>
The host system is perfectly accessible and on show minimal CPU usages.
A running <span style="font-weight: bold;">top</span>
session within the UML also show low CPU and moderate memory usage.
However the UML's load increases up to 3.x for several minutes and then
recovers. <br>
System Data:
<br>
<ul>
Host:
  <br>
AMD Athlon 2.1Ghz running Gentoo using 2.6.9 kernel with skas3 patch. <br>
1 SCSI 18G drive (boot drive) and one IDE 15G drive.
  <br>
1G tmpfs
  <br>
UML:
  <br>
Vanilla 2.4.27 UML kernel (patched of UML usage)
  <br>
3G file system and 512M swap.
  <br>
The UML is run using 512M of mem.
  <br>
The UML runs from the IDE drive.
</ul>
<br>
Thanks<br>
<br>
</span>
</body>
</html>

--------------020607060100020902000300--

--=======AVGMAIL-41F0A6975630=======
Content-Type: text/plain; x-avg=cert; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Description: "AVG certification"

No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.300 / Virus Database: 265.7.1 - Release Date: 19/01/2005

--=======AVGMAIL-41F0A6975630=======--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
