Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4Nsi-0004JZ-37 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Feb 2005 10:38:36 -0800
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D4NsH-00007O-0u for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Feb 2005 10:38:36 -0800
Received: from NHROCAVG2.ets.enterasys.com ([134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id j1OIc6ZC024338
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 24 Feb 2005 13:38:06 -0500 (EST)
Message-ID: <421E1F0D.4040108@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] UML startup -- segfault with no mm
References: <421D59C5.9020003@enterasys.com>
	<200502241736.j1OHaFha003688@ccure.user-mode-linux.org>
In-Reply-To: <200502241736.j1OHaFha003688@ccure.user-mode-linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCFE465D41D340D576C04A7AE"
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
Date: Thu, 24 Feb 2005 13:38:05 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCFE465D41D340D576C04A7AE
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

actually - 2.4.26-3um looks like this already.

int start_uml_skas(void)
{
    start_userspace(0);
    capture_signal_stack();

    init_new_thread_signals(1);
    idle_timer();

    init_task.thread.request.u.thread.proc = start_kernel_proc;
    init_task.thread.request.u.thread.arg = NULL;

so this doesn't play into it as it just put the
idle_timer in 2.6 back where it was in 2.4:

***************
*** 224,232 ****
  {
      start_userspace(0);
      capture_signal_stack();
-     uml_idle_timer();

      init_new_thread_signals(1);

      init_task.thread.request.u.thread.proc = start_kernel_proc;
      init_task.thread.request.u.thread.arg = NULL;
--- 224,232 ----
  {
      start_userspace(0);
      capture_signal_stack();

      init_new_thread_signals(1);
+     uml_idle_timer();



Jeff Dike wrote:

>dbahi@enterasys.com said:
>
>
>>here's a wonderfully infrequent but nagging startup failure that
>>usually has a useless (no stack depth, or just corrupt) backtrace...
>>
>>
>
>You need the uml-enable-the-timer-after-the-timer-handler.patch patch:
>
>	http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm1/broken-out/uml-enable-the-timer-after-the-timer-handler.patch
>
>				Jeff
>
>
>

--
db


--------------enigCFE465D41D340D576C04A7AE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCHh8N3XQ4zakZ3z4RAvqcAJ9PRPy13jq2rdF8kZ8vMM+dLCCMdgCeLCsi
d2t60fN1UGwONARbN1hMVOE=
=Vx2d
-----END PGP SIGNATURE-----

--------------enigCFE465D41D340D576C04A7AE--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
