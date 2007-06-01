Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Htua7-0002EJ-Pj for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 May 2007 17:01:27 -0700
Received: from agminet01.oracle.com ([141.146.126.228])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Htua6-0004U7-Dt
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 May 2007 17:01:27 -0700
Date: Thu, 31 May 2007 17:00:29 -0700
From: Zach Brown <zach.brown@oracle.com>
Message-ID: <20070601000029.GN5488@mami.zabbo.net>
References: <20070531181923.GA9904@c2.user-mode-linux.org>
	<20070531220716.GL5488@mami.zabbo.net>
	<20070531233946.GA12493@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070531233946.GA12493@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] Syslets - Fix cachemiss_thread return value
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

> the demos I sent out.  Dunno about the existing ones, but I bet they do
> the same.

Hmm, they didn't when I ran them, but I'll give yours a try and take a
closer look.  Thanks for taking the time to bring it up.

- z

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
