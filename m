Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMX1l-003FGH-9F
 for linux-um@lists.infradead.org; Wed, 17 Mar 2021 14:20:02 +0000
Received: by mail-il1-x12d.google.com with SMTP id d2so1632364ilm.10
 for <linux-um@lists.infradead.org>; Wed, 17 Mar 2021 07:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1611103406.git.thehajime@gmail.com>
 <b3b73864dbb738d0de7c49a6df5a5f53a358ec93.1611103406.git.thehajime@gmail.com>
 <2b649bc5165c7ff4547abd72f7e03e7491980138.camel@sipsolutions.net>
 <m25z1rc2ux.wl-thehajime@gmail.com>
 <56af0e44c846f4b079256ec997c56119964be402.camel@sipsolutions.net>
In-Reply-To: <56af0e44c846f4b079256ec997c56119964be402.camel@sipsolutions.net>
From: Octavian Purdila <tavi.purdila@gmail.com>
Date: Wed, 17 Mar 2021 16:19:48 +0200
Message-ID: <CAMoF9u2phDz5nmFFSW-9VKs2gTK0exHaPxrOf4nM5gAQnQhcRQ@mail.gmail.com>
Subject: Re: [RFC v8 19/20] um: lkl: add block device support of UML
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-kernel-library <linux-kernel-library@freelists.org>, linux-arch <linux-arch@vger.kernel.org>, Akira Moroo <retrage01@gmail.com>

On Tue, Mar 16, 2021 at 11:32 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Tue, 2021-03-16 at 10:19 +0900, Hajime Tazaki wrote:
> >
> > > > --- a/arch/um/Kconfig
> > > > +++ b/arch/um/Kconfig
> > > > @@ -29,6 +29,10 @@ config UMMODE_LIB
> > > >   select UACCESS_MEMCPY
> > > >   select ARCH_THREAD_STACK_ALLOCATOR
> > > >   select ARCH_HAS_SYSCALL_WRAPPER
> > > > + select VFAT_FS
> > > > + select NLS_CODEPAGE_437
> > > > + select NLS_ISO8859_1
> > > > + select BTRFS_FS
> > >
> > > That doesn't really seem to make sense - the sample might need it, but
> > > generally LKL doesn't/shouldn't?
> >
> > I'm trying to understand your comment;
> > Do you mean that enabling those options in Kconfig doesn't make sense ?
>
> I mean *always* enabling them doesn't make sense. Why shouldn't somebody
> be allowed to build UMMODE_LIB *without* btrfs? If they have no need for
> btrfs, why should it select it?
>
> I can understand that your sample code wants btrfs just to show what it
> can do, but IMHO it doesn't make sense to *always* enable it.
>

I agree. I think these can stay in defconfigs but here is where a
library introduces complications which I don't know how is best to
handle. Should we have the defconfig in arch/um or should we have it
in tools/testing/selftests/um? Or perhaps both places, one being a
generic config that would be used by most applications and one
customized?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

