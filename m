Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ejf0h-0004AH-4X for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Dec 2005 07:45:43 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ejf0e-0001oq-EP
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Dec 2005 07:45:43 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 10DE0C6F82
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  6 Dec 2005 15:44:21 +0000 (GMT)
Received: from mail.nagafix.co.uk ([127.0.0.1])
	by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00911-09 for
	<user-mode-linux-devel@lists.sourceforge.net>; 
	Tue,  6 Dec 2005 15:44:19 +0000 (GMT)
Received: from ant.internal (88-96-60-221.dsl.zen.co.uk [88.96.60.221])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 3AC75C6F81
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  6 Dec 2005 15:44:08 +0000 (GMT)
From: Antoine Martin <antoine@nagafix.co.uk>
Content-Type: text/plain
Message-Id: <1133883874.6202.39.camel@ant.internal>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] fakehd and tty logging
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
Date: Tue, 06 Dec 2005 15:44:34 +0000
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

I just noticed this patch:
http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.15-rc3/patches/no-fakehd
Anyone trying to use UML for honeypots will need this feature.
But since tty-logging is also missing from 2.6, I don't use it.
However I would hope that one day the tty logging gets re-added to 2.6
then I would probably want to use both features for honeypots.

"The fakehd switch lost its implementation at some point. Since no one
is screaming for it, we might as well remove it."

Please please please (not screaming yet).

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
