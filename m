Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4cCe-0006WG-0U for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 02:23:52 -0700
Received: from ns2.tops.net ([212.79.190.253] helo=mail2.tops.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C4cCZ-0007CU-AC
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 02:23:50 -0700
Received: from x11.topsnet-ads.tops.net (prometheus.tops.net [212.79.160.29])
	by mail2.tops.net (8.12.8/8.12.8) with ESMTP id i879MfXx030180
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 7 Sep 2004 11:22:41 +0200
From: Ralph Passgang <ralph@debianbase.de>
Subject: Re: [uml-devel] uml modules broken in 2.6.8 (has something to do with
	memmove)
References: <200409060005.54577.ralph@debianbase.de>
	<200409062005.08014.blaisorblade_spam@yahoo.it>
In-Reply-To: <200409062005.08014.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200409071122.40804.ralph@debianbase.de>
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
Date: Tue, 7 Sep 2004 11:22:40 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Am Montag, 6. September 2004 20:05 schrieben Sie:
> On Monday 06 September 2004 00:05, Ralph Pa=DFgang wrote:
> > Hi all,
> >
> > I am not a kernel hacker, but I found with google that something changed
> > with memmove in 2.6.8, but I don't know enough of the kernel stuff to
> > know what it means:
> >
> > http://kerneltrap.org/node/view/3443 -> search for memmove and you find:
> > "i386: uninline memmove"
>
> Well, smart catch. If you know C, I can explain this.=20

I know C a bit, but I am not were good in it... But I always want to learn =
to=20
get better :)

> Before memmove was an=20
> inline function defined in kernel headers, while in 2.6.8. I hope you are
> using 2.6.8.1, actually, because 2.6.8 is known-buggy for nfs. Well, no,
> you say 2.6.8. However, I guess that Debian-source includes the fix.

Yes, the debian package should include the fix. it is already the 5th versi=
on=20
of the 2.6.8 kernel-source package in debian and the changelog says that a =

nfs-bugfix is included (with some more fixes).

I guess the debian package maintainer didn't used the 2.6.8.1 versionnumber=
,=20
because it could produce a lot of problems in other packages/scripts that=20
expect X.Y.Z format.

> > Has nobody besides me this problem? I can't use my uml without nat, so I
> > downgraded again to 2.6.6...
>
> Solutions in such cases are (waiting for the fix):

I waited for some days to see if somebody is saying something about memmove=
 in=20
the uml-mailinglists or if I find a 2.6.8.1-2 patch in the uml homepage. Bu=
t=20
because I didn't found anything I started asking myself, espacially because=
=20
some other people seems to used the 2.6.8.1 without any problem...

> - compiling what you need in the kernel rather than as a module

I noticed that myself for another module (a bit ago)... But I don't want al=
l=20
iptables modules + ppp,pppoe + a lot other modules to be in the kernel rath=
er=20
than as module. If the problem just occours for one module, that is a fix=20
indeed :)

> - if you get complaints about a certain symbol, i.e. memmove, just add a
> EXPORT_SYMBOL(memmove) and the prototype (or the appropriate include) in
> arch/um/kernel/ksyms.c and recompile the kernel (you don't need to
> recompile the modules).

I will try to fix the next problem (hopefully there will be no errors at al=
l=20
in upcoming versions *g*) on my own. Exporting kernelsymbols is not what I =
am=20
used to do every day, but that seems not to be too difficult.

> In this case, apply this patch with patch -p1 -l:
>
> diff -puN arch/um/os-Linux/user_syms.c~uml-export-Symbols
> arch/um/os-Linux/user_syms.c ---
> uml-linux-2.6.8.1/arch/um/os-Linux/user_syms.c~uml-export-Symbols =20
> 2004-08-29 14:40:56.000000000 +0200 +++
> uml-linux-2.6.8.1-paolo/arch/um/os-Linux/user_syms.c        2004-08-29
> 14:40:56.000000000 +0200 @@ -14,12 +14,14 @@
>
>  extern size_t strlen(const char *);
>  extern void *memcpy(void *, const void *, size_t);
> +extern void *memmove(void *, const void *, size_t);
>  extern void *memset(void *, int, size_t);
>  extern int printf(const char *, ...);
>
>  EXPORT_SYMBOL(strlen);
>  EXPORT_SYMBOL(memcpy);
>  EXPORT_SYMBOL(memset);
> +EXPORT_SYMBOL(memmove);
>  EXPORT_SYMBOL(printf);
>
>  EXPORT_SYMBOL(strstr);
>
> If you experience other module-related problems, you may want to use the
> attached patch, however I'm not sure it will apply on your tree.

It applied without a problem and I also have compiled it for debian sid and=
=20
sarge. Now my 2.6.8 uml runs without any problems, even iptables_nat and=20
pppoe works like charm :)

Thank you for the patch... Keep the good work up, I love UML :)...

--Ralph


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idP47&alloc_id=10808&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
