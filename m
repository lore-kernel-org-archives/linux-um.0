Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dg4Ve-0007Mh-RY	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Jun 2005 10:38:34 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user93210)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Dg4Vc-00019H-Tu	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Jun 2005 10:38:34 -0700
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1DfSPm-0008Vv-Va@nuthatch.gentoo.org>
	<200506071844.58916.blaisorblade@yahoo.it>
	<871x7e54pv.fsf@amaterasu.srvr.nix>
	<200506080234.29043.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200506080234.29043.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's message of "Wed, 8 Jun 2005 02:34:28 +0200")
Message-ID: <87mzq03g1d.fsf@amaterasu.srvr.nix>
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
Date: Wed, 08 Jun 2005 18:38:22 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, 8 Jun 2005, blaisorblade@yahoo.it said:
> On Tuesday 07 June 2005 21:47, Nix wrote:
>> On Tue, 7 Jun 2005, blaisorblade@yahoo.it suggested tentatively:
>> > On Tuesday 07 June 2005 18:21, Nix wrote:
>> >> OK, so it's a -static TT build that's failing?
>> >
>> > Exactly.
>>
>> Built, with a randomly selected .config (that is, a .config I use for
>> other things, not a .config with the values set at random!)
> Hmm, broken-out in the archives works perfectly (with patch-scripts). Go until 
> uml-link-tt-mode-against-nptl.patch and retry, and possibly even with the 
> previous one... please.

OK, will do.

>> With that applied, it builds...
>>
>> ... and segfaults almost at once on invocation:
>>
>> execve("./vmlinux", ["./vmlinux"], [/* 49 vars */]) = 0
>> uname({sys="Linux", node="hades", ...}) = 0
>> brk(0)                                  = 0xa0343000
>> brk(0xa0343834)                         = 0xa0343834
>> set_thread_area({entry_number:-1 -> 6, base_addr:0xa034381c, limit:1048575,
>> seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
>> seg_not_present:0, useable:1}) = 0 --- SIGSEGV (Segmentation fault) @ 0 (0)
> 
> Hmm, gdb would be more helpful... I was getting a SIGBUS somewhere on x86_64 
> (with a native binary) here, and maybe it could be the same thing (no, it 
> can't, your error is different, so I'm talking to myself):

Unlikely: this isn't an x86-64 box ;}

> And here is the memory map... whoops! The code is trying to read from 
> 60c00000, which is mapped... but from an absurd address! And from a different 
> file from all the rest!
[snip]
> 60c00000-a2000000 rwxs ffffffffc0c00000 00:0e 
> 1383102                    /tmp/vm_file-JmW1nY (deleted)

Whaa?

>> Looks like a thread initialization problem to *me*. And there be very
>> serious and nasty snarling dragons with sharp pointy carborundum teeth
> Hmm, can you pass those along to kill the Computer against which I'm playing 
> at Warcraft III?

;)

>> :(
> This kind of problems is normally caused from wrong alignments in the linker 
> script.

I'm not surprised it dies: even ld can see that something's wrong. With
V=1 we see this:

        gcc -static -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc -o vmlinux -Wl,-T,arch/um/kernel/vmlinux.lds   init/built-in.o -Wl,--start-group  usr/built-in.o  arch/um/kernel/built-in.o  arch/um/drivers/built-in.o  arch/um/os-Linux/built-in.o  arch/um/sys-i386/built-in.o  arch/i386/crypto/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  lib/built-in.o  drivers/built-in.o  sound/built-in.o  net/built-in.o -Wl,--end-group -lutil .tmp_kallsyms3.o ; rm -f linux
/usr/bin/ld: BFD 2.16.90.0.3 20050510 assertion fail elf.c:3833

which is the assertion here, inside
bfd/elf.c:map_sections_to_segments():

  /* If there are any SHF_TLS output sections, add PT_TLS segment.  */
  if (tls_count > 0)
    {
      int i;

      amt = sizeof (struct elf_segment_map);
      amt += (tls_count - 1) * sizeof (asection *);
      m = bfd_zalloc (abfd, amt);
      if (m == NULL)
	goto error_return;
      m->next = NULL;
      m->p_type = PT_TLS;
      m->count = tls_count;
      /* Mandated PF_R.  */
      m->p_flags = PF_R;
      m->p_flags_valid = 1;
      for (i = 0; i < tls_count; ++i)
	{
	  BFD_ASSERT (first_tls->flags & SEC_THREAD_LOCAL);
	  m->sections[i] = first_tls;
	  first_tls = first_tls->next;
	}

      *pm = m;
      pm = &m->next;
    }

>> > Alternatively, use patch1.bz2 and patch2.bz2, which have normal context
>> > (the final patch has been generated by merging them).
>>
>> ... I used these, which applied fine.
> Btw, I forgot that broken-out is in perfect state and would help more for 
> debug...

I'll try that next.

>> Well, it's done that in the south-east of England, too, but I don't have
>> to like it, and it's `exceptional' (i.e. `has happened almost every year
>> for the last decade' :( )
> Global warming, isn't it? However don't worry, the Gulf Current is going to 
> stop so you'll get refreshed of -10 degrees...

Excellent. Bring back the ice age!

(Hm. My house wouldn't stand up well under a kilometre of ice...)

-- 
`It's as bizarre an intrusion as, I don't know, the hobbits coming home
 to find that the Shire has been taken over by gangsta rappers.'


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
