Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXqZA-0006L2-He	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 18:08:12 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DXn1e-00031P-RP
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 14:28:15 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1DXn1Z-0006zr-SM	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 14:21:20 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Explaination of system call function flow in TT mode
Message-ID: <20050516205233.GA9668@ccure.user-mode-linux.org>
References: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
	<200501282010.50020.blaisorblade@yahoo.it>
	<3524bf1f05051607085609e111@mail.gmail.com>
	<200505161908.08373.blaisorblade@yahoo.it>
	<3524bf1f05051611528eb7bc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3524bf1f05051611528eb7bc1@mail.gmail.com>
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
Date: Mon, 16 May 2005 16:52:33 -0400
To: Young Koh <young.koh@gmail.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Mon, May 16, 2005 at 02:52:37PM -0400, Young Koh wrote:
> Suppose the tracee attmpts to invoke a host system call. then, it will
> be intercepted by the tracer as in TT mode. (In TT mode, the tracer
> turns off tracing and sends SIGUSR2 to the tracee, and then, the
> signal handler in the tracee will execute the system call.) but, in
> SKAS mode, because the tracee doesn't have the UML kernel code, only
> the tracer knows about the system call code. The tracer cannot simply
> send a signal to make the tracee execute the system call. Then how
> does it do? Does the tracer execute the system call for the tracee?

The tracer is the kernel, so it just executes the system call.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
