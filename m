Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CmsTT-00030D-33 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jan 2005 03:40:11 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CmsTR-0005uF-Dz
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jan 2005 03:40:11 -0800
Subject: Re: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE
	9.2)
References: <200412140958.58402.Armin.Warda@ePost.De>
	<040e01c4f272$c44e35f0$0201a8c0@hawk> <20050105112813.GA14779@bytesex>
	<200501051522.52632.Armin.Warda@gmx.de>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <200501051522.52632.Armin.Warda@gmx.de>
Message-ID: <87wtup8p00.fsf@bytesex.org>
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
Date: 07 Jan 2005 12:20:15 +0100
To: Armin.Warda@gmx.De
Cc: user-mode-linux-devel@lists.sourceforge.net

"Armin M. Warda" <Armin.Warda@gmx.de> writes:

> On Wednesday 05 January 2005 12:28, Gerd Knorr wrote:
> > > > # mount tmpfs tmp/ -t tmpfs
> > > > # TMPDIR=./tmp/ /kernels/non-fix-kill-patched-kernel
> > > > rootfs=debian.fs # uml_mconsole .uml/xxx/mconsole cad
> > > > # kill -KILL <pid1> <pid2>
> >
> > That doesn't kill all the processes, I additionally need 'kill
> > -CONT' for one of them.
> 
> I remember that behaviour you describe from the uml-kernel that was 
> delivered on SuSE 9.2's Distribution media, um-host-kernel-2.6.8-24.* 
> 
> But my 2.6.9-bb4 um-kernel does not show that problem, I think because 
> bb4 has that fix-kill patch inside.

Yep, but without the fix-kill patch it's reporty easier to trigger.  I
still can't reproduce it on my machine though for some reason, hints
very welcome.  It happens to me only when some uml process still hangs
around, and after killing it off I can umount the filesystem just fine.

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
