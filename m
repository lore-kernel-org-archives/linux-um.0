Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CoS4D-0001JP-3h for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 11:52:37 -0800
Received: from thor.65535.net ([216.17.104.19])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CoS49-0004Be-87
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 11:52:35 -0800
Received: from [212.228.151.253] (helo=jackhammer)
	by thor.65535.net with esmtp (Exim 4.20) id 1CoRyh-000J0C-N6
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 11:46:56 -0800
From: Rus Foster <rghf@fsck.me.uk>
Message-ID: <Pine.LNX.4.58.0501111951490.26769@jackhammer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Hang on Reboot
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
Date: Tue, 11 Jan 2005 19:54:17 +0000 (GMT)
To: user-mode-linux-devel@lists.sourceforge.net

I've just built a 2.4.29-rc1 kernel with BB's uml-2.4.27-bs1.patch and 
uml-patch-2.4.24-1base.patch upon issuing a reboot the UML just sits there 
after INIT: Finish all processes (or similar)

I can see a 2.6.x patch which looks like it would fix it but any idea on 
2.4. BTW running in SKAS mode

Rus

-- 
e: rghf@vpscolo.com : t: 1-888-327-6330       
http://www.vaserv.com - Coming soon. Email sales@vaserv.com for more info
http://www.storemypic.com - Free Image Hosting
http://www.vpsforums.com - Talk for VPS users and Providers



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
