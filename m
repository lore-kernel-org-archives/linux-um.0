Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXPpN-0000vW-IK
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 10:58:21 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AXPpN-0005bu-1M
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 10:58:21 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [patch] host-skas support for 2.6.0, other UML fixes
References: <Pine.LNX.4.58.0312171735540.8123@earth> <Pine.LNX.4.58.0312181122070.32554@earth> <Pine.LNX.4.58.0312181209230.1327@earth>
In-Reply-To: <Pine.LNX.4.58.0312181209230.1327@earth>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312191959.12681.blaisorblade_spam@yahoo.it>
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
Date: Fri, 19 Dec 2003 19:59:12 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 12:17, gioved=EC 18 dicembre 2003, Ingo Molnar ha scritto:
> Jeff,
>
> i've ported host-skas support to the 2.6.0 kernel. (patch attached.) The
> patching order is:
>
>   - create the 2.6.0 tree,
>   - apply user-mode-linux.org/mirror/uml-patch-2.6.0-test9-1.bz2,
>   - apply the attached uml-host-skas-2.6.0-A0 patch
>
> other changes:
>
>   - cleaned up the LDT changes (pass around mm not task)

Some other ports of the SKAS3 patch to 2.6 did also this: rename the new=20
version of do_mmap_pgoff as __do_mmap_pgoff, and put this new definition in=
=20
the header:

static inline unsigned long do_mmap_pgoff(struct file * file,
                            unsigned long addr, unsigned long len,
                            unsigned long prot, unsigned long flags,
                            unsigned long pgoff) {
__do_mmap_pgoff(current->mm, file, addr, len, prot, flags, pgoff);
}

so we avoid breaking compatibility for possible other patches/other code.
Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
