Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3DNg-0001U7-Oh for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Sep 2004 05:41:28 -0700
Received: from ns.lbox.cz ([62.129.50.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C3DNe-0007oZ-8m for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Sep 2004 05:41:27 -0700
Received: from mail.cubenet.cz (mail.cubenet.cz [62.129.60.162])
	by ns.lbox.cz (8.11.6/8.11.6) with ESMTP id i83CfJZ25806
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 3 Sep 2004 14:41:19 +0200
Received: from linuxbox.linuxbox.cz (IDENT:root@[10.76.66.10])
	by mail.cubenet.cz (8.11.6/8.11.6) with ESMTP id i83CfDQ25224
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 3 Sep 2004 14:41:13 +0200
Received: from [10.76.66.13] (develbox.linuxbox.cz [10.76.66.13])
	by linuxbox.linuxbox.cz (8.12.8/8.12.8) with ESMTP id i83CfCVM014769
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 3 Sep 2004 14:41:13 +0200
From: Nikola Ciprich <extmaillist@linuxbox.cz>
Content-Type: multipart/mixed; boundary="=-ZW2njrF2OLw0hZWQlfmU"
Message-Id: <1094215272.22770.12.camel@develbox.linuxbox.cz>
Mime-Version: 1.0
Subject: [uml-devel] PATCH - add crypto api config options to 2.4.x uml
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
Date: Fri, 03 Sep 2004 14:41:12 +0200
To: UML devel list <user-mode-linux-devel@lists.sourceforge.net>


--=-ZW2njrF2OLw0hZWQlfmU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
this is just one-line change, cryptoapi seems to work well inside UML
(I'm using it for ppp_mppe_mppc 1.1)
Could someone apply it? btw are some special rules for patch submission?
I could not find any...
thanks
Nik.
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


--=-ZW2njrF2OLw0hZWQlfmU
Content-Disposition: attachment; filename=linux-2.4.27-uml-cfg-cryptoapi.patch
Content-Type: text/x-patch; name=linux-2.4.27-uml-cfg-cryptoapi.patch;
	charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur linux-2.4.27/arch/um/config.in linux-2.4.27-uml-cfg-cryptoapi/arch/um/config.in
--- linux-2.4.27/arch/um/config.in	2004-09-03 14:32:49.341551178 +0200
+++ linux-2.4.27-uml-cfg-cryptoapi/arch/um/config.in	2004-09-03 13:46:34.000000000 +0200
@@ -103,6 +103,8 @@
 
 source lib/Config.in
 
+source crypto/Config.in
+
 mainmenu_option next_comment
 comment 'Kernel hacking'
 bool 'Debug memory allocations' CONFIG_DEBUG_SLAB

--=-ZW2njrF2OLw0hZWQlfmU--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
