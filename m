Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Clqfh-0006vM-B5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Jan 2005 07:32:33 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Clqfc-0006A7-9F for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Jan 2005 07:32:32 -0800
Message-ID: <040e01c4f272$c44e35f0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <200412140958.58402.Armin.Warda@ePost.De>
	<200501031531.19246.Armin.Warda@gmx.de>
	<20050104115947.GA3715@bytesex>
	<200501041506.05104.Armin.Warda@gmx.de>
	<20050104143911.GA5248@bytesex>
Subject: Re: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE
	9.2)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Tue, 4 Jan 2005 09:33:36 -0600
To: Gerd Knorr <kraxel@bytesex.org>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Paolo Giarrusso <blaisorblade_personal@yahoo.it>, "Armin M. Warda" <Armin.Warda@gmx.de>

> Hmm, it's not reproducable here, I can umount tmpfs after running
> uml just fine.  Any other conditions are needed to trigger it?
> 
>   Gerd

Here's a post of mine which details a sure fire way to reproduce it every time

http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=110324354001225&w=2

> My method for causing the problem every time (example works under 2.6.9-ck3 and
> 2.6.10-rc2-bk7)
> 
> # mount tmpfs tmp/ -t tmpfs
> # TMPDIR=./tmp/ /kernels/non-fix-kill-patched-kernel rootfs=debian.fs
> # uml_mconsole .uml/xxx/mconsole cad
> # kill -KILL <pid1> <pid2>
> # umount tmp/
> umount: /root/tmp: device is busy
> 
> (cad is set to shutdown in the UML's inittab.  After sending CAD, it hangs, which
> requires kill)

Any old kernel that doesn't have the fix-kill patch will do, but here's one:
http://www.theshore.net/~caker/uml/kernels/2.4.26-linode31-1um

-Chris



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
