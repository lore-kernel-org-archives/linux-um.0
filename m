Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1idMQM-00064J-Rn
 for linux-um@lists.infradead.org; Fri, 06 Dec 2019 22:50:12 +0000
Received: by mail-pl1-x644.google.com with SMTP id w7so3315954plz.12
 for <linux-um@lists.infradead.org>; Fri, 06 Dec 2019 14:50:07 -0800 (PST)
MIME-Version: 1.0
References: <20191206020153.228283-1-brendanhiggins@google.com>
 <20191206020153.228283-3-brendanhiggins@google.com>
 <aa7b77aa-bf3a-6919-ed66-37af00d856d2@cambridgegreys.com>
In-Reply-To: <aa7b77aa-bf3a-6919-ed66-37af00d856d2@cambridgegreys.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 6 Dec 2019 14:49:55 -0800
Message-ID: <CAFd5g45_PaL_rSbhrUD1RJ1ZWasptG+z7TO9_B4-Qafs90L2KA@mail.gmail.com>
Subject: Re: [RFC v1 2/2] uml: remove support for CONFIG_STATIC_LINK
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: johannes.berg@intel.com, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Gow <davidgow@google.com>

On Thu, Dec 5, 2019 at 11:41 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
> On 06/12/2019 02:01, Brendan Higgins wrote:
> > CONFIG_STATIC_LINK appears to have been broken since before v4.20. It
> > doesn't play nice with CONFIG_UML_NET_VECTOR=y:
> >
> > /usr/bin/ld: arch/um/drivers/vector_user.o: in function
> > `user_init_socket_fds': vector_user.c:(.text+0x430): warning: Using
> > 'getaddrinfo' in statically linked applications requires at runtime the
> > shared libraries from the glibc version used for linking
> >
> > And it seems to break the ptrace check:
> >
> > Checking that ptrace can change system call numbers...check_ptrace :
> > child exited with exitcode 6, while expecting 0; status 0x67f
> > [1]    126822 abort      ./linux mem=256M
> >
> > Given the importance of ptrace in UML, CONFIG_STATIC_LINK seems totally
> > broken right now; remove it in order to fix allyesconfig for ARCH=um.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
[...]
> The ptrace check was discussed on the list this week - it is the enable
> constructors commit in 5.3-rc1.
>
> A patch reverting it was submitted by Johannes yesterday.
>
> I did not try disabling/enabling static link - good catch.
>
> Otherwise, I agree - static link should probably go.
>
> Adding PCAP throws even more warnings and the AF_XDP work I have in
> progress generates a whole page of them. Considering that the resulting
> executable is not really static there is no point keeping the option.

Sounds good. I will send this out again as a non-RFC patch.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

