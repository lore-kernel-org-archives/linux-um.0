Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Subject: Re: [uml-user] Re: [uml-devel] new skas3 patch ready for 2.4.25
References: <40338C1B.1070800@meisterwerk.net>
	<200402202125.58574.blaisorblade_spam@yahoo.it>
	<87k72gv3cg.fsf@amaterasu.srvr.nix>
	<200402221516.09898.blaisorblade_spam@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200402221516.09898.blaisorblade_spam@yahoo.it> (BlaisorBlade's
	message of "Sun, 22 Feb 2004 16:00:38 +0100")
Message-ID: <87u11jrnwk.fsf@amaterasu.srvr.nix>
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
Date: Sun, 22 Feb 2004 18:04:43 +0000
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Sun, 22 Feb 2004, BlaisorBlade said:
> Hmmm, I've looked at the faulting code and IMHO the most probable thing is a 
> compilation problem (forgot make dep after applying the patch, for instance) - 
> try saving your .config, running make mrproper, 
> grepping through .config to check that CONFIG_PROC_MM=y and recompiling the 
> bzImage:
>  $ make dep bzImage

It's highly plausible that exactly that happened: I forgot `make
oldconfig' during the first build and assumed (ha!) that `make dep'
would fix everything up OK so that a config change would trigger
rebuilds appropriately. Possibly this was a foolish assumption and a
`make dep clean' was necessary.

> More exactly, it seems that arch/i386/kernel/ptrace.c was recompiled after 
> applying the patch but without CONFIG_PROC_MM on.

OK.

> Also, IMHO that kind of error cannot be returned by sys_ptrace, unless 
> CONFIG_PROC_MM was off when compiling that file (I've also checked 
> proc_mm_get_mm).

That's my conclusion too. I'll try rebuilding from scratch tomorrow
evening and see if that works.

(Oops.)

-- 
`note to the crown prosecution service: Machine guns dont have a
 'stun' setting.' --- mjw


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
