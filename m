Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cm9Wm-0004n6-Lh for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Jan 2005 03:40:36 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Cm9Wh-0004PY-IO
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Jan 2005 03:40:36 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE
	9.2)
Message-ID: <20050105112813.GA14779@bytesex>
References: <200412140958.58402.Armin.Warda@ePost.De>
	<200501031531.19246.Armin.Warda@gmx.de>
	<20050104115947.GA3715@bytesex>
	<200501041506.05104.Armin.Warda@gmx.de>
	<20050104143911.GA5248@bytesex>
	<040e01c4f272$c44e35f0$0201a8c0@hawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <040e01c4f272$c44e35f0$0201a8c0@hawk>
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
Date: Wed, 5 Jan 2005 12:28:13 +0100
To: "Christopher S. Aker" <caker@theshore.net>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Paolo Giarrusso <blaisorblade_personal@yahoo.it>, "Armin M. Warda" <Armin.Warda@gmx.de>

> > # mount tmpfs tmp/ -t tmpfs
> > # TMPDIR=./tmp/ /kernels/non-fix-kill-patched-kernel rootfs=debian.fs
> > # uml_mconsole .uml/xxx/mconsole cad
> > # kill -KILL <pid1> <pid2>

That doesn't kill all the processes, I additionally need 'kill -CONT'
for one of them.

> > # umount tmp/
> > umount: /root/tmp: device is busy

Works for me, at least when no uml kernel process left over.  Sure there
are no uml processes hanging around any more at this point?

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
