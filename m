Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYX7Q-0001a3-I6	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 15:34:24 -0700
Received: from rproxy.gmail.com ([64.233.170.200])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DYX7O-0004Zn-Vc	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 15:34:24 -0700
Received: by rproxy.gmail.com with SMTP id j1so236524rnf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 18 May 2005 15:34:22 -0700 (PDT)
Message-ID: <3524bf1f0505181534a2436e7@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Subject: Re: [uml-devel] copy_from_user in SKAS mode
In-Reply-To: <20050518150802.GB18740@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
References: <3524bf1f0505171633edddc7@mail.gmail.com>
	 <20050518011827.GA13287@ccure.user-mode-linux.org>
	 <3524bf1f05051806474362d786@mail.gmail.com>
	 <20050518150802.GB18740@ccure.user-mode-linux.org>
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
Date: Wed, 18 May 2005 18:34:22 -0400
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Ok, let me have an example.

suppose a user argument has virtual address 0xa0, corresponding UML
physical address 0xb0, and real physical address 0x10. so, when the
user process tries to access 0xa0 for the first time, the UML kernel
should let host kernel know there will be 0xa0 -> 0x10 mapping. how
does the UML kernel make another process's address map to the same
physical page it has? and how does the UML kernel keep track of 0xa0
-> 0xb0 mapping? maybe the same page table mechanism as host Linux? (i
guess so, though)

Thanks a lot!


On 5/18/05, Jeff Dike <jdike@addtoit.com> wrote:
> On Wed, May 18, 2005 at 09:47:37AM -0400, Young Koh wrote:
> > you mean "physical" to the UML kernel?
>=20
> Yes.  To the host, it's just normal process virtual memory, but to UML,
> that's its physical memory.
>=20
> > Because the UML kernel cannot
> > know about the real physical pages in the host kernel,  do you mean
> > the UML kernel finds out which its (virtual) address maps to the same
> > real physical page that the user process's address maps to? but the
> > UML kernel and the user process would have different mappings and
> > cannot know about each other (if so, its a protection violation
> > between processes) Could you explain a bit more? Thanks a lot!!!
>=20
> It's exactly the same as the host.  There is physical memory mapped into
> its address space, and pages from that area are allocated and mapped into
> process address spaces as needed.  In skas mode, UML has no direct access
> to the process address spaces (like the x86 4G/4G split), so it has to
> translate the process virtual address into a UML physical address, to whi=
ch
> it does have access, and can copy the data.
>=20
>                                 Jeff
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
