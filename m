Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYOtg-0002wl-CU	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 06:47:40 -0700
Received: from rproxy.gmail.com ([64.233.170.205])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DYOte-00020F-Vf	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 06:47:40 -0700
Received: by rproxy.gmail.com with SMTP id j1so107470rnf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 18 May 2005 06:47:37 -0700 (PDT)
Message-ID: <3524bf1f05051806474362d786@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Subject: Re: [uml-devel] copy_from_user in SKAS mode
In-Reply-To: <20050518011827.GA13287@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
References: <3524bf1f0505171633edddc7@mail.gmail.com>
	 <20050518011827.GA13287@ccure.user-mode-linux.org>
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
Date: Wed, 18 May 2005 09:47:37 -0400
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

> Since UML has no direct access to the process userspace (i.e. process
> virtual addresses are meaningless in the kernel), it has to translate
> them to physical addresses.  So, each page containing a piece of the
> incoming buffer is translated into a physical page, and the data copied
> from there.

you mean "physical" to the UML kernel? Because the UML kernel cannot
know about the real physical pages in the host kernel,  do you mean
the UML kernel finds out which its (virtual) address maps to the same
real physical page that the user process's address maps to? but the
UML kernel and the user process would have different mappings and
cannot know about each other (if so, its a protection violation
between processes) Could you explain a bit more? Thanks a lot!!!

-Young

>=20
>                                Jeff
>


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_idt12&alloc_id=16344&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
