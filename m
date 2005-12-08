Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkBID-0007oU-92 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Dec 2005 18:13:57 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EkBIC-0006oE-OV
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Dec 2005 18:13:57 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 4E88A43B1B
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  8 Dec 2005 02:12:33 +0000 (GMT)
Received: from mail.nagafix.co.uk ([127.0.0.1])
	by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08475-03 for
	<user-mode-linux-devel@lists.sourceforge.net>; 
	Thu,  8 Dec 2005 02:12:31 +0000 (GMT)
Received: from [192.168.0.2] (host-87-74-21-109.bulldogdsl.com [87.74.21.109])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 3DB8F43A21
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  8 Dec 2005 02:12:31 +0000 (GMT)
From: Antoine Martin <antoine@nagafix.co.uk>
Content-Type: text/plain
Message-Id: <1134008028.32598.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] tls: set_thread_area failed
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
Date: Thu, 08 Dec 2005 02:13:48 +0000
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

I'm still trying to get a regular FC4 image to boot with the latest x86
tls support code. (since Gentoo works fine)
but this is what I get:
# fsck.ext3 -a /dev/ubda
set_thread_area failed when setting up thread-local storage
Segmentation fault

Is this glibc? Any ideas?

Thanks
Antoine



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
