Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GrrJ4-0000BU-IR for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Dec 2006 23:35:07 -0800
Received: from [218.104.33.231] (helo=centecnetworks.com)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GrrIu-0000F6-JJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Dec 2006 23:35:05 -0800
Received: from [127.0.0.1] ([218.104.33.229])
	(envelope-sender <qmiao@centecnetworks.com>)
	by 192.168.25.7 with ESMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 06 Dec 2006 15:34:45 +0800
Message-ID: <45767282.1060802@centecnetworks.com>
Date: Wed, 06 Dec 2006 15:34:26 +0800
From: Miao Qingjun <qmiao@centecnetworks.com>
MIME-Version: 1.0
Subject: [uml-devel] uml crashes
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1561789636=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============1561789636==
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=GB2312" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
Here is a list of uml crash messages.<br>
(uml guest: 2.6.18, uml host:2.6.12+skas3)<br>
<font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US"><o:p></o:p></span></font>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">BUG: failure
at linux/mm/prio_tree.c:125/vma_prio_tree_remove()!<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">Kernel panic
- not syncing: BUG!<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">&nbsp;<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">EIP:
0073:[&lt;40015791&gt;] CPU: 0 Tainted:
P&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ESP: 007b:bf8ec4fc EFLAGS: 00000206<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">&nbsp;&nbsp;&nbsp; Tainted:
P&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">EAX: ffffffda
EBX: 401e8000 ECX: 00015800 EDX:
4001afb4<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">ESI: bf8ec554
EDI: <st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="80531" unitname="C" w:st="on">080531c</st1:chmetcnv>0
EBP: bf8ec688 DS: 007b ES: 007b<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">139aa8:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="80712" unitname="C" w:st="on">080712c</st1:chmetcnv>1&gt;]
show_regs+0xed/0x<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="10" unitname="F" w:st="on">10f</st1:chmetcnv><o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="139" unitname="ac" w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">139ac</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">4:&nbsp;
[&lt;0805da00&gt;] panic_exit+0x<st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="2" unitname="C"
 w:st="on">2c</st1:chmetcnv>/0x4b<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">139ad4:&nbsp;
[&lt;08085871&gt;] notifier_call_chain+0x28/0x<st1:chmetcnv tcsc="0"
 numbertype="1" negative="False" hasspace="False" sourcevalue="3"
 unitname="F" w:st="on">3f</st1:chmetcnv><o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">139af4:&nbsp;
[&lt;0808591e&gt;] atomic_notifier_call_chain+0x<st1:chmetcnv tcsc="0"
 numbertype="1" negative="False" hasspace="False" sourcevalue="1"
 unitname="F" w:st="on">1f</st1:chmetcnv>/0x21<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">139b08:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="8076" unitname="a" w:st="on">08076a</st1:chmetcnv>08&gt;]
panic+0x71/0x100<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">139b24:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="80" unitname="a" w:st="on">080a</st1:chmetcnv>227d&gt;]
vma_prio_tree_next+0x0/0x4b<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">139b48:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="80" unitname="a" w:st="on">080a</st1:chmetcnv><st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="6" unitname="a" w:st="on">6a</st1:chmetcnv><st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="5" unitname="a" w:st="on">5a</st1:chmetcnv>&gt;]
__remove_shared_vm_struct+0x48/0x64<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">139b<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="5" unitname="C" w:st="on">5c</st1:chmetcnv>:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="80" unitname="a" w:st="on">080a</st1:chmetcnv><st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="6" unitname="a" w:st="on">6a</st1:chmetcnv><st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="9" unitname="C" w:st="on">9c</st1:chmetcnv>&gt;]
unlink_file_vma+0x26/0x28<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">139b70:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="80" unitname="a" w:st="on">080a</st1:chmetcnv>3b48&gt;]
free_pgtables+0x2d/0x79<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">139b98:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="80" unitname="a" w:st="on">080a</st1:chmetcnv>83d5&gt;]
unmap_region+0xb8/0xea<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">139bcc:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="80" unitname="a" w:st="on">080a</st1:chmetcnv>8684&gt;]
do_munmap+0xde/0x159<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">139bf8:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="80" unitname="a" w:st="on">080a</st1:chmetcnv>873b&gt;]
sys_munmap+0x<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="3" unitname="C" w:st="on">3c</st1:chmetcnv>/0x<st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="4" unitname="F" w:st="on">4f</st1:chmetcnv><o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="139" unitname="C" w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">139c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">18:&nbsp;
[&lt;0805e<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="3" unitname="C" w:st="on">3c</st1:chmetcnv>4&gt;]
handle_syscall+0xc8/0xe4<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="139" unitname="C" w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">139c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">88:&nbsp;
[&lt;0806d949&gt;] userspace+0x<st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="2" unitname="a"
 w:st="on">2a</st1:chmetcnv>2/0x<st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="3" unitname="a"
 w:st="on">3a</st1:chmetcnv>6<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">139cf0:&nbsp;
[&lt;0805e041&gt;] fork_handler+0xe2/0xf0<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="0" unitname="a"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">0a</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">139d20:&nbsp;
[&lt;b<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="7" unitname="F" w:st="on">7f</st1:chmetcnv>00420&gt;]
0xb<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="7" unitname="F" w:st="on">7f</st1:chmetcnv>00420<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US"><o:p>&nbsp;</o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US"><o:p>&nbsp;</o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US"><o:p>&nbsp;</o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US"><o:p>&nbsp;</o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">Kernel panic
- not syncing: Segfault with no mm<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">&nbsp;<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">EIP:
0073:[&lt;b7fc6402&gt;] CPU: 0 Tainted:
P&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ESP: 007b:b7fc2fa8 EFLAGS: 00000<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">246<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">&nbsp;&nbsp;&nbsp; Tainted:
P&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">EAX: 00000000
EBX: 00005e44 ECX: 00000013 EDX:
00005e44<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">ESI: 00005e3e
EDI: 00000011 EBP: b7fc2fb8 DS: 007b ES:
007b<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3d5b0:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="80712" unitname="C" w:st="on">080712c</st1:chmetcnv>1&gt;]
show_regs+0xed/0x<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="10" unitname="F" w:st="on">10f</st1:chmetcnv><o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3d5cc:&nbsp;
[&lt;0805da00&gt;] panic_exit+0x<st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="2" unitname="C"
 w:st="on">2c</st1:chmetcnv>/0x4b<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3d5dc:&nbsp;
[&lt;08085871&gt;]
notifier_call_chain+0x28/0x<st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="3" unitname="F"
 w:st="on">3f</st1:chmetcnv><o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3d5fc:&nbsp;
[&lt;0808591e&gt;]
atomic_notifier_call_chain+0x<st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="1" unitname="F"
 w:st="on">1f</st1:chmetcnv>/0x21<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3d610:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="8076" unitname="a" w:st="on">08076a</st1:chmetcnv>08&gt;]
panic+0x71/0x100<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3d<st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="62" unitname="C" w:st="on">62c</st1:chmetcnv>:&nbsp;
[&lt;0805d137&gt;] segv+0x279/0x2e7<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3d<st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="6" unitname="F" w:st="on">6f</st1:chmetcnv>8:&nbsp;
[&lt;0805ceb8&gt;] segv_handler+0x<st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="6" unitname="F"
 w:st="on">6f</st1:chmetcnv>/0x75<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3d<st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="71" unitname="C" w:st="on">71c</st1:chmetcnv>:&nbsp;
[&lt;0806e352&gt;] sig_handler_common_skas+0xc2/0xfd<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3d740:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="806" unitname="a" w:st="on">0806a</st1:chmetcnv>615&gt;]
sig_handler+0x<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="2" unitname="F" w:st="on">2f</st1:chmetcnv>/0x<st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="4" unitname="C" w:st="on">4c</st1:chmetcnv><o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3d758:&nbsp;
[&lt;b7fc6420&gt;] 0xb7fc6420<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3da48:&nbsp;
[&lt;080d493d&gt;]
__sync_single_inode+0xe6/0x20d<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3da78:&nbsp;
[&lt;080d4b00&gt;]
__writeback_single_inode+0x<st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="9" unitname="C"
 w:st="on">9c</st1:chmetcnv>/0x177<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="FR">09b3dae0:&nbsp;
[&lt;080d4d<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="4" unitname="F" w:st="on">4f</st1:chmetcnv>&gt;]
sync_sb_inodes+0x174/0x2ca<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3db<st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="1" unitname="C" w:st="on">1c</st1:chmetcnv>:&nbsp;
[&lt;080d<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="4" unitname="F" w:st="on">4f</st1:chmetcnv>26&gt;]
writeback_inodes+0x81/0x83<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3db38:&nbsp;
[&lt;0809e517&gt;]
wb_kupdate+0x75/0xe8<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3db<st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="8" unitname="C" w:st="on">8c</st1:chmetcnv>:&nbsp;
[&lt;0809ed54&gt;] __pdflush+0xc4/0x162<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3dbb0:&nbsp;
[&lt;0809ee41&gt;] pdflush+0x<st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="4" unitname="F"
 w:st="on">4f</st1:chmetcnv>/0x51<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3dbf0:&nbsp;
[&lt;0808bcfa&gt;] kthread+0xb2/0xda<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3dc<st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="2" unitname="C" w:st="on">2c</st1:chmetcnv>:&nbsp;
[&lt;08069b57&gt;] run_kernel_thread+0x50/0x69<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3dce0:&nbsp;
[&lt;0805dee1&gt;]
new_thread_handler+0xbc/0x10e<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">09b3dd20:&nbsp;
[&lt;b7fc6420&gt;] 0xb7fc6420<o:p></o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US"><o:p>&nbsp;</o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US"><o:p>&nbsp;</o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US"><o:p>&nbsp;</o:p></span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">BUG: warning
at linux/kernel/irq/manage.c:353/free_irq()<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59268:&nbsp;
[&lt;0805bd72&gt;] dump_stack+0x22/0x24<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59280:&nbsp;
[&lt;08096e6b&gt;] free_irq+0x116/0x11b<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="592" unitname="ac" w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">592ac</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">:&nbsp;
[&lt;08062d53&gt;] close_devices+0x<st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="2" unitname="a"
 w:st="on">2a</st1:chmetcnv>/0x84<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="592" unitname="C" w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">592c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">0:&nbsp;
[&lt;0805aaa3&gt;] do_uml_exitcalls+0x13/0x21<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">592cc:&nbsp;
[&lt;0805b1e8&gt;] uml_cleanup+0x12/0x19<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">592d4:&nbsp;
[&lt;0805b206&gt;] machine_power_off+0x8/0xf<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">592dc:&nbsp;
[&lt;0805b215&gt;] machine_halt+0x8/0xb<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">592e4:&nbsp;
[&lt;0805da1b&gt;] panic_exit+0x47/0x4b<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="592" unitname="F" w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">592f</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">4:&nbsp;
[&lt;08085391&gt;] notifier_call_chain+0x28/0x<st1:chmetcnv tcsc="0"
 numbertype="1" negative="False" hasspace="False" sourcevalue="3"
 unitname="F" w:st="on">3f</st1:chmetcnv><o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59314:&nbsp;
[&lt;0808543e&gt;] atomic_notifier_call_chain+0x<st1:chmetcnv tcsc="0"
 numbertype="1" negative="False" hasspace="False" sourcevalue="1"
 unitname="F" w:st="on">1f</st1:chmetcnv>/0x21<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59328:&nbsp;
[&lt;08076528&gt;] panic+0x71/0x100<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59344:&nbsp;
[&lt;0805d0af&gt;] segv+0x<st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="1" unitname="F"
 w:st="on">1f</st1:chmetcnv>1/0x2e7<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59410:&nbsp;
[&lt;0805ceb8&gt;] segv_handler+0x<st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="6" unitname="F"
 w:st="on">6f</st1:chmetcnv>/0x75<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59434:&nbsp;
[&lt;0806de72&gt;] sig_handler_common_skas+0xc2/0xfd<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59458:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="806" unitname="a" w:st="on">0806a</st1:chmetcnv>135&gt;]
sig_handler+0x<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="2" unitname="F" w:st="on">2f</st1:chmetcnv>/0x<st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="4" unitname="C" w:st="on">4c</st1:chmetcnv><o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59470:&nbsp;
[&lt;b7fb1420&gt;] 0xb7fb1420<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59768:&nbsp;
[&lt;08089575&gt;] __rcu_process_callbacks+0x67/0xb4<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59780:&nbsp;
[&lt;080895dc&gt;] rcu_process_callbacks+0x<st1:chmetcnv tcsc="0"
 numbertype="1" negative="False" hasspace="False" sourcevalue="1"
 unitname="a" w:st="on">1a</st1:chmetcnv>/0x30<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59790:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="807" unitname="C" w:st="on">0807c</st1:chmetcnv>83b&gt;]
tasklet_action+0x44/0x<st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="9" unitname="a"
 w:st="on">9a</st1:chmetcnv><o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">597b0:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="807" unitname="C" w:st="on">0807c</st1:chmetcnv>537&gt;]
__do_softirq+0x<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="5" unitname="C" w:st="on">5c</st1:chmetcnv>/0xc8<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">597d4:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="807" unitname="C" w:st="on">0807c</st1:chmetcnv>5ec&gt;]
do_softirq+0x49/0x<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="4" unitname="F" w:st="on">4f</st1:chmetcnv><o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="FR">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="FR">597e8:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="807" unitname="C" w:st="on">0807c</st1:chmetcnv>639&gt;]
irq_exit+0x47/0x<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="4" unitname="F" w:st="on">4f</st1:chmetcnv><o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">597fc:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="805" unitname="C" w:st="on">0805c</st1:chmetcnv>267&gt;]
timer_handler+0x<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="3" unitname="F" w:st="on">3f</st1:chmetcnv>/0x78<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59818:&nbsp;
[&lt;0806de72&gt;] sig_handler_common_skas+0xc2/0xfd<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="5983" unitname="C" w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">5983c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">:&nbsp;
[&lt;08069dc6&gt;] real_alarm_handler+0x37/0x58<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59854:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="806" unitname="a" w:st="on">0806a</st1:chmetcnv><st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="0" unitname="F" w:st="on">0f</st1:chmetcnv>7&gt;]
alarm_handler+0x48/0x57<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59868:&nbsp;
[&lt;b7fb1420&gt;] 0xb7fb1420<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59bfc:&nbsp;
[&lt;<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="80950" unitname="C" w:st="on">080950c</st1:chmetcnv>8&gt;]
sys_init_module+0x51/0x178<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="59" unitname="C" w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">59c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">18:&nbsp;
[&lt;0805e<st1:chmetcnv tcsc="0" numbertype="1" negative="False"
 hasspace="False" sourcevalue="3" unitname="C" w:st="on">3c</st1:chmetcnv>4&gt;]
handle_syscall+0xc8/0xe4<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><st1:chmetcnv
 tcsc="0" numbertype="1" negative="False" hasspace="False"
 sourcevalue="59" unitname="C" w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">59c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">88:&nbsp;
[&lt;0806d469&gt;] userspace+0x<st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="2" unitname="a"
 w:st="on">2a</st1:chmetcnv>2/0x<st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="3" unitname="a"
 w:st="on">3a</st1:chmetcnv>6<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59cf0:&nbsp;
[&lt;0805e041&gt;] fork_handler+0xe2/0xf0<o:p></o:p></span></font></p>
<p class="MsoNormal"><st1:chmetcnv tcsc="0" numbertype="1"
 negative="False" hasspace="False" sourcevalue="27" unitname="C"
 w:st="on"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">27c</span></font></st1:chmetcnv><font
 face="Arial" size="1"><span style="font-size: 9pt; font-family: Arial;"
 lang="EN-US">59d20:&nbsp;
[&lt;b7fb1420&gt;] 0xb7fb1420<br>
</span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US">VFS: Close:
file count is 0<br>
Kernel panic - not syncing: Kernel mode fault at addr 0x9, ip 0x400007e2<br>
&nbsp;<br>
EIP: 0073:[&lt;400007e2&gt;] CPU: 0 Tainted: P&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ESP: 007b:bfb2d068
EFLAGS: 00000212<br>
&nbsp;&nbsp;&nbsp; Tainted: P&nbsp;&nbsp;&nbsp;&nbsp; <br>
EAX: ffffffda EBX: 00000000 ECX: 00005401 EDX: bfb2d078<br>
ESI: 406baa64 EDI: 40177ff4 EBP: bfb2d0a8 DS: 007b ES: 007b<br>
09b6d730:&nbsp; [&lt;080712c1&gt;] show_regs+0xed/0x10f<br>
09b6d74c:&nbsp; [&lt;0805da00&gt;] panic_exit+0x2c/0x4b<br>
09b6d75c:&nbsp; [&lt;08085871&gt;] notifier_call_chain+0x28/0x3f<br>
09b6d77c:&nbsp; [&lt;0808591e&gt;] atomic_notifier_call_chain+0x1f/0x21<br>
09b6d790:&nbsp; [&lt;08076a08&gt;] panic+0x71/0x100<br>
09b6d7ac:&nbsp; [&lt;0805d0af&gt;] segv+0x1f1/0x2e7<br>
09b6d878:&nbsp; [&lt;0805ceb8&gt;] segv_handler+0x6f/0x75<br>
09b6d89c:&nbsp; [&lt;0806e352&gt;] sig_handler_common_skas+0xc2/0xfd<br>
09b6d8c0:&nbsp; [&lt;0806a615&gt;] sig_handler+0x2f/0x4c<br>
09b6d8d8:&nbsp; [&lt;b7f67420&gt;] 0xb7f67420<br>
09b6dbf0:&nbsp; [&lt;080c4fd0&gt;] sys_ioctl+0x3b/0x5b<br>
09b6dc18:&nbsp; [&lt;0805e3c4&gt;] handle_syscall+0xc8/0xe4<br>
09b6dc88:&nbsp; [&lt;0806d949&gt;] userspace+0x2a2/0x3a6<br>
09b6dcf0:&nbsp; [&lt;0805e041&gt;] fork_handler+0xe2/0xf0<br>
09b6dd20:&nbsp; [&lt;b7f67420&gt;] 0xb7f6742</span></font></p>
<p class="MsoNormal"><font face="Arial" size="1"><span
 style="font-size: 9pt; font-family: Arial;" lang="EN-US"><br>
BUG: warning at linux/kernel/irq/manage.c:353/free_irq()<br>
winch_interrupt : read failed, errno = 9<br>
fd 31 is losing SIGWINCH support<br>
299e5a38:&nbsp; [&lt;0805bd72&gt;] dump_stack+0x22/0x24<br>
299e5a50:&nbsp; [&lt;0809734b&gt;] free_irq+0x116/0x11b<br>
299e5a7c:&nbsp; [&lt;0806151a&gt;] free_winch+0x59/0x67<br>
299e5a90:&nbsp; [&lt;08061568&gt;] winch_cleanup+0x16/0x27<br>
299e5aa0:&nbsp; [&lt;0805aaa3&gt;] do_uml_exitcalls+0x13/0x21<br>
299e5aac:&nbsp; [&lt;0805b1e8&gt;] uml_cleanup+0x12/0x19<br>
299e5ab4:&nbsp; [&lt;0805b206&gt;] machine_power_off+0x8/0xf<br>
299e5abc:&nbsp; [&lt;0805b215&gt;] machine_halt+0x8/0xb<br>
299e5ac4:&nbsp; [&lt;0805da1b&gt;] panic_exit+0x47/0x4b<br>
299e5ad4:&nbsp; [&lt;08085871&gt;] notifier_call_chain+0x28/0x3f<br>
299e5af4:&nbsp; [&lt;0808591e&gt;] atomic_notifier_call_chain+0x1f/0x21<br>
299e5b08:&nbsp; [&lt;08076a08&gt;] panic+0x71/0x100<br>
299e5b24:&nbsp; [&lt;080ab350&gt;] vunmap+0x0/0x5f<br>
299e5b40:&nbsp; [&lt;080949dd&gt;] load_module+0x9d/0xbf1<br>
299e5bfc:&nbsp; [&lt;080955a8&gt;] sys_init_module+0x51/0x178<br>
299e5c18:&nbsp; [&lt;0805e3c4&gt;] handle_syscall+0xc8/0xe4<br>
299e5c88:&nbsp; [&lt;0806d949&gt;] userspace+0x2a2/0x3a6<br>
299e5cf0:&nbsp; [&lt;0805e041&gt;] fork_handler+0xe2/0xf0<br>
299e5d20:&nbsp; [&lt;b7fa9420&gt;] 0xb7fa9420<br>
</span></font></p>
BUG: warning at linux/kernel/irq/manage.c:353/free_irq()<br>
299e5a48:&nbsp; [&lt;0805bd72&gt;] dump_stack+0x22/0x24<br>
299e5a60:&nbsp; [&lt;0809734b&gt;] free_irq+0x116/0x11b<br>
299e5a8c:&nbsp; [&lt;08063235&gt;] close_devices+0x2a/0x84<br>
299e5aa0:&nbsp; [&lt;0805aaa3&gt;] do_uml_exitcalls+0x13/0x21<br>
299e5aac:&nbsp; [&lt;0805b1e8&gt;] uml_cleanup+0x12/0x19<br>
299e5ab4:&nbsp; [&lt;0805b206&gt;] machine_power_off+0x8/0xf<br>
299e5abc:&nbsp; [&lt;0805b215&gt;] machine_halt+0x8/0xb<br>
299e5ac4:&nbsp; [&lt;0805da1b&gt;] panic_exit+0x47/0x4b<br>
299e5ad4:&nbsp; [&lt;08085871&gt;] notifier_call_chain+0x28/0x3f<br>
299e5af4:&nbsp; [&lt;0808591e&gt;] atomic_notifier_call_chain+0x1f/0x21<br>
299e5b08:&nbsp; [&lt;08076a08&gt;] panic+0x71/0x100<br>
299e5b24:&nbsp; [&lt;080ab350&gt;] vunmap+0x0/0x5f<br>
299e5b40:&nbsp; [&lt;080949dd&gt;] load_module+0x9d/0xbf1<br>
299e5bfc:&nbsp; [&lt;080955a8&gt;] sys_init_module+0x51/0x178<br>
299e5c18:&nbsp; [&lt;0805e3c4&gt;] handle_syscall+0xc8/0xe4<br>
299e5c88:&nbsp; [&lt;0806d949&gt;] userspace+0x2a2/0x3a6<br>
299e5cf0:&nbsp; [&lt;0805e041&gt;] fork_handler+0xe2/0xf0<br>
299e5d20:&nbsp; [&lt;b7fa9420&gt;] 0xb7fa9420<br>
<br>
</body>
</html>



--===============1561789636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1561789636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1561789636==--
