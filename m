Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpBS5-0005Yl-JN for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 12:20:17 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CpBS4-0008OT-SH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 12:20:17 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 8/8] uml: depend on !USERMODE in
	drivers/block/Kconfig and drop arch/um/Kconfig_block
References: <20050113051341.DD29D6325A@zion>
	<200501131956.22703.blaisorblade@yahoo.it>
	<200501132206.j0DM67ha005650@ccure.user-mode-linux.org>
In-Reply-To: <200501132206.j0DM67ha005650@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501132122.38517.blaisorblade@yahoo.it>
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
Date: Thu, 13 Jan 2005 21:22:38 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it

On Thursday 13 January 2005 23:06, Jeff Dike wrote:
> blaisorblade@yahoo.it said:
> > Ok, what you'd like is an additional patch however, because
> > CONFIG_USERMODE  has existed for ages, so for now this can go in,
> > right?
>
> Yup, your patches are in my tree.
Ok, thanks for quick merging - I hope that Andrew Morton merges it also 
directly, since I CC'ed him.

And seeing you so promptly answer probably means that I'll no longer need to 
queue patches on my own tree, and to find a way to snapshot it; this is a 
good improvement over the past and helps my work. Thanks a lot for it.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
