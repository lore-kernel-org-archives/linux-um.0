Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cp1C4-0003zp-W9 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 01:23:04 -0800
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cp1C3-00076n-2W for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 01:23:04 -0800
Message-ID: <54814.80.203.0.208.1105608180.squirrel@80.203.0.208>
In-Reply-To: <200501121936.16890.blaisorblade@yahoo.it>
References: <50806.80.203.0.208.1105530488.squirrel@80.203.0.208>
	<200501121833.03286.blaisorblade@yahoo.it>
	<52224.80.203.0.208.1105554129.squirrel@80.203.0.208>
	<200501121936.16890.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] df -h and hostfs
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Date: Thu, 13 Jan 2005 10:23:00 +0100 (CET)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: stian@nixia.no, user-mode-linux-devel@lists.sourceforge.net

After I got away the double mounts it seems to be correct. So probably me
that made a mess somewhere that night. I'm done dumping files now so I
could reboot it and recheck the stuff. And the double mounts probably made
the result from df appear wrong, since the kernel walks the mount list
forward when trying to locate the affected filesytems, while all other
file-operations walks it backwards. So it seems to be general
kernel-problem when you have mounted a mount-point two times (Either with
intension or accident)


Stian


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
