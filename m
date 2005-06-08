Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfoTf-0002OL-QA	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 17:31:27 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DfoTb-0005nh-R8	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 17:31:27 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1DfSPm-0008Vv-Va@nuthatch.gentoo.org>
	<200506071844.58916.blaisorblade@yahoo.it> <871x7e54pv.fsf@amaterasu.srvr.nix>
In-Reply-To: <871x7e54pv.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_V0jpCou4eEtXuMy"
Message-Id: <200506080234.29043.blaisorblade@yahoo.it>
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
Date: Wed, 8 Jun 2005 02:34:28 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nix <nix@esperi.org.uk>

--Boundary-00=_V0jpCou4eEtXuMy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 07 June 2005 21:47, Nix wrote:
> On Tue, 7 Jun 2005, blaisorblade@yahoo.it suggested tentatively:
> > On Tuesday 07 June 2005 18:21, Nix wrote:
> >> OK, so it's a -static TT build that's failing?
> >
> > Exactly.
>
> Built, with a randomly selected .config (that is, a .config I use for
> other things, not a .config with the values set at random!)
Hmm, broken-out in the archives works perfectly (with patch-scripts). Go un=
til=20
uml-link-tt-mode-against-nptl.patch and retry, and possibly even with the=20
previous one... please.

> Not quite built without problems. Can you guess the cause of this?

> Guess where the static libutil.a is. That's right, /usr/lib. Are
> we searching it in that linker script? No :(
Ok, wait that I emerge that newer version and build starts failing here too=
=20
and you'll get that fixed. A proper patch (ok for whatever SUBARCH you need=
)=20
would be ok, either... Ok, it's doable because I must now link in=20
arch/um/sys-SUBARCH/unmap_fin.o (it's done in -bs6 too), by passing=20
=2DDSUBARCH=3D$(SUBARCH). You can pass a define for the path, too.

>
> With that applied, it builds...
>
> ... and segfaults almost at once on invocation:
>
> execve("./vmlinux", ["./vmlinux"], [/* 49 vars */]) =3D 0
> uname({sys=3D"Linux", node=3D"hades", ...}) =3D 0
> brk(0)                                  =3D 0xa0343000
> brk(0xa0343834)                         =3D 0xa0343834
> set_thread_area({entry_number:-1 -> 6, base_addr:0xa034381c, limit:104857=
5,
> seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
> seg_not_present:0, useable:1}) =3D 0 --- SIGSEGV (Segmentation fault) @ 0=
 (0)

Hmm, gdb would be more helpful... I was getting a SIGBUS somewhere on x86_6=
4=20
(with a native binary) here, and maybe it could be the same thing (no, it=20
can't, your error is different, so I'm talking to myself):

(gdb) c
Continuing.
Checking for /proc/mm...found
Checking for the skas3 patch in the host...not found
Checking PROT_EXEC mmap in /tmp...OK

Program received signal SIGBUS, Bus error.
0x00000000601fee40 in memset ()
(gdb) where
#0  0x00000000601fee40 in memset ()
#1  0x0000000060006f4e in init_bootmem_core ()
#2  0x0000000060011259 in setup_physmem ()
#3  0x000000006001870d in linux_main ()
#4  0x000000006000fe91 in main ()

=46rom the value in memset registers and from the code, it's this call in=20
init_bootmem_core():
        memset(bdata->node_bootmem_map, 0xff, mapsize);

And here is the memory map... whoops! The code is trying to read from=20
60c00000, which is mapped... but from an absurd address! And from a differe=
nt=20
file from all the rest!

$ cat /proc/904/maps
60000000-60001000 rwxp 00000000 fe:02=20
1173995                            /home/paolo/Admin/kernel/6/clean-linux-2=
=2E6.11/vmlinux
60001000-60238000 rwxs 00000000 00:0e=20
1383099                            /tmp/vm_file-VOy5x5 (deleted)
60238000-60325000 rwxs 00000000 00:0e=20
1383100                            /tmp/vm_file-16FWOn (deleted)
60325000-6045b000 rwxs 00000000 00:0e=20
1383101                            /tmp/vm_file-8DBi6F (deleted)
6045b000-6047c000 rwxp 6045b000 00:00 0                                 =20
[heap]
60c00000-a2000000 rwxs ffffffffc0c00000 00:0e=20
1383102                    /tmp/vm_file-JmW1nY (deleted)
2aaaaaaab000-2aaaaaaac000 rwxp 2aaaaaaab000 00:00 0
7fffffae1000-7fffffaf6000 rwxp 7fffffae1000 00:00 0                     =20
[stack]
ffffffffff600000-ffffffffffe00000 ---p 00000000 00:00 0                 =20
[vdso]

> Looks like a thread initialization problem to *me*. And there be very
> serious and nasty snarling dragons with sharp pointy carborundum teeth
Hmm, can you pass those along to kill the Computer against which I'm playin=
g=20
at Warcraft III?
> :(
This kind of problems is normally caused from wrong alignments in the linke=
r=20
script.

> (this box, btw, is an AMD Athlon 4: it *does* have CMOV support. Not
> that that could plausibly be the problem here.)

> Whoops!

> I guess not many people have tried to build -bs6, then: I doubt that would
> work terribly well in skas mode, either ;)
Guess it wouldn't build stop.
> > Seems like I'll have to resort to something bad... which is attached,
> > i.e. black magic (using -U from time to time).
>
> Black magic during debugging makes me nervous, so...

> > Alternatively, use patch1.bz2 and patch2.bz2, which have normal context
> > (the final patch has been generated by merging them).
>
> ... I used these, which applied fine.
Btw, I forgot that broken-out is in perfect state and would help more for=20
debug...


> `Seasonal allergic rhinitis',
Exactly.
> i.e., plants trying to have sex with my=20
> nose over my violent protests.

> Well, it's done that in the south-east of England, too, but I don't have
> to like it, and it's `exceptional' (i.e. `has happened almost every year
> for the last decade' :( )
Global warming, isn't it? However don't worry, the Gulf Current is going to=
=20
stop so you'll get refreshed of -10 degrees...
=2D-=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_V0jpCou4eEtXuMy
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-pcap-on-64bit-host.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-pcap-on-64bit-host.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 clean-linux-2.6.11-paolo/arch/um/drivers/Makefile       |    4 ++--
 clean-linux-2.6.11-paolo/arch/um/scripts/Makefile.unmap |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/um/drivers/Makefile~uml-pcap-on-64bit-host arch/um/drivers/Makefile
--- clean-linux-2.6.11/arch/um/drivers/Makefile~uml-pcap-on-64bit-host	2005-06-08 02:09:55.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/drivers/Makefile	2005-06-08 02:09:55.000000000 +0200
@@ -17,10 +17,10 @@ ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
 
-LDFLAGS_pcap.o := -r -lpcap -L/usr/lib
+LDFLAGS_pcap.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libpcap.a)
 
 $(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)/pcap_user.o
-	$(LD) -r -dp -o $@ $^ $(LDFLAGS_pcap.o)
+	$(LD) -r -dp -o $@ $^ $(LDFLAGS) $(LDFLAGS_pcap.o)
 #XXX: The call below does not work because the flags are added before the
 # object name, so nothing from the library gets linked.
 #$(call if_changed,ld)
diff -puN arch/um/scripts/Makefile.unmap~uml-pcap-on-64bit-host arch/um/scripts/Makefile.unmap
--- clean-linux-2.6.11/arch/um/scripts/Makefile.unmap~uml-pcap-on-64bit-host	2005-06-08 02:09:55.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/scripts/Makefile.unmap	2005-06-08 02:09:55.000000000 +0200
@@ -15,7 +15,7 @@ $(obj)/unmap.o: _c_flags = $(__UNMAP_CFL
 
 quiet_cmd_wrapld = LD      $@
 define cmd_wrapld
-	$(LD) $(LDFLAGS) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) -print-file-name=libc.a); \
+	$(LD) $(LDFLAGS) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) $(CFLAGS) -print-file-name=libc.a); \
 	$(OBJCOPY) $(UML_OBJCOPYFLAGS) $(obj)/unmap_tmp.o $@ -G switcheroo
 endef
 
_

--Boundary-00=_V0jpCou4eEtXuMy--

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
