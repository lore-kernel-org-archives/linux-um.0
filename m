Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATZ1o-0008K5-5S
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 19:59:16 -0800
Received: from ns.sws.net.au ([61.95.69.3])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ATZ1n-0000fa-Hv
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 19:59:15 -0800
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
Subject: Re: [uml-devel] mounting COW on HOST?
References: <009701c3bded$d0efef70$2000000a@schlepptopp> <1070935808.4256.25.camel@profx.lonnon.org>
In-Reply-To: <1070935808.4256.25.camel@profx.lonnon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312091458.56576.russell@coker.com.au>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 9 Dec 2003 14:58:56 +1100
Content-Transfer-Encoding: quoted-printable
To: greg@lonnon.org, roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 9 Dec 2003 13:10, greg <greg@lonnon.org> wrote:
> It wouldn't be that tough to write a COW block device for the standard
> kernel. =A0In fact, if we did that, we could get rid of the COW hack in
> the ubd device.

Isn't this already done via LVM snapshots?

--=20
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
