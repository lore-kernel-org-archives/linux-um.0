Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPGhA-00033m-BY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 00:40:44 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CPGh6-0004U2-3G
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 00:40:44 -0800
Subject: Re: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
	<200411021952.09095.blaisorblade_spam@yahoo.it>
	<41884ACC.2020309@vgertech.com>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <41884ACC.2020309@vgertech.com>
Message-ID: <878y9jib8z.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: 03 Nov 2004 09:32:12 +0100
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Nuno Silva <nuno.silva@vgertech.com> writes:

> Yes, maybe it was me and, FWIW, I never found a solution to make a
> dynamic skas uml run under 2.6+libcNTPL.

The usual workaround for any nptl issues works here as well:
export LD_ASSUME_KERNEL=2.4.21

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
