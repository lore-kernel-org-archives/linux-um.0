Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6mrm-0003Sf-Ur for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Mar 2004 00:39:02 -0800
Received: from ns.lbox.cz ([62.129.50.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6mrl-0002xY-Bf for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Mar 2004 00:39:01 -0800
Received: from mail.cubenet.cz (mail.cubenet.cz [62.129.60.162])
	by ns.lbox.cz (8.11.6/8.11.6) with ESMTP id i2Q8cvh16514
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Mar 2004 09:38:57 +0100
Received: from linuxbox.linuxbox.cz ([10.76.66.10])
	by mail.cubenet.cz (8.11.6/8.11.6) with ESMTP id i2Q8csO19753
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Mar 2004 09:38:54 +0100
Received: from linuxbox.linuxbox.cz (localhost.localdomain [127.0.0.1])
	by linuxbox.linuxbox.cz (8.12.8/8.12.8) with ESMTP id i2Q8bR42002458
	for <user-mode-linux-devel@lists.sourceforge.net.OUTNOCOPY>;
	Fri, 26 Mar 2004 09:37:27 +0100
Received: (from mail@localhost)
	by linuxbox.linuxbox.cz (8.12.8/8.12.8/Submit) id i2Q8bRfm002454
	for user-mode-linux-devel@lists.sourceforge.net.OUTNOCOPY;
	Fri, 26 Mar 2004 09:37:27 +0100
Received: from [10.76.66.13] (develbox.linuxbox.cz [10.76.66.13])
	by linuxbox.linuxbox.cz (8.12.8/8.12.8) with ESMTP id i2Q8bL42002441
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Mar 2004 09:37:21 +0100
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Reply-To: nikola.ciprich@linuxbox.cz
Content-Type: text/plain
Message-Id: <1080290324.6040.2.camel@develbox>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] mppe kernel module under UML
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
Date: Fri, 26 Mar 2004 09:38:45 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hello all,
I'd like to ask:
I've been using UML for testing pptp, with mppe encryption enabled, and
it was pretty useful to me. but now I'm trying to use new mppe kernel
module from ppp-2.4.2(CVS version), and i doesn't seem to appear in make
ARCH=um menuconfig. what does availability of module in uml
configuration depend on? I think it is totally hardware independent and
I had no problems using old version under UML. Any suggestions? 
thanks all in advance
NiK
-- 
-------------------------------------
Nikola CIPRICH
LinuxBox.cz, s.r.o.
28. rijna 168, 709 01 Ostrava

tel.:   +420 596 603 142
fax:    +420 596 621 273
mobil:  +420 777 093 799
www.linuxbox.cz

mobil servis: +420 737 238 656
email servis: servis@linuxbox.cz
-------------------------------------




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
