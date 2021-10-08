Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYtFQ-003esI-WD
 for linux-um@lists.infradead.org; Fri, 08 Oct 2021 17:01:30 +0000
Received: by mail-qt1-x831.google.com with SMTP id i1so8969110qtr.6
 for <linux-um@lists.infradead.org>; Fri, 08 Oct 2021 10:01:28 -0700 (PDT)
Date: Fri, 8 Oct 2021 12:01:21 -0500
From: Glenn Washburn <development@efficientek.com>
Subject: Re: Using GDB to debug a user space process in UML
Message-ID: <20211008120121.0932b2c9@crass-HP-ZBook-15-G2>
In-Reply-To: <aeac5d6ec9a59becbe84be6484bb312b216045ad.camel@sipsolutions.net>
References: <20211007013601.45fa8947@crass-HP-ZBook-15-G2>
 <CABqSeAQgYiBq7USUkb-fPZkXi6rtYeew_u1Gwg4Uxp9J3=NxsQ@mail.gmail.com>
 <aeac5d6ec9a59becbe84be6484bb312b216045ad.camel@sipsolutions.net>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: development@efficientek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: YiFei Zhu <zhuyifei1999@gmail.com>, linux-um <linux-um@lists.infradead.org>

On Thu, 07 Oct 2021 21:16:40 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Thu, 2021-10-07 at 11:41 -0700, YiFei Zhu wrote:
> > On Wed, Oct 6, 2021 at 11:36 PM Glenn Washburn
> > <development@efficientek.com> wrote:
> > > 
> > > I'm trying to debug a crash in busybox while it is the init process in
> > > a UML instance. I'm having trouble breaking on the entry point of the
> > > busybox binary. I'm pretty new to this space, so I'm proceeding from a
> > > lot of ignorance, please correct me where I'm wrong and help me clear
> > > up some things.
> > 
> > AFAIK, that isn't possible, but not because of address space
> > translation, but because UML is already ptracing user space threads.
> 
> Indeed.
> 
> My brother posted some (incomplete and not entirely working yet) patches
> recently here on the list to allow not using ptrace but seccomp instead,

Do you have an idea of what is not working? The only thing I see
referenced in the cover letter[1] seems to be more of a security issue
and a functionality issue. So don't run the patch on untrusted code.
Anything else I should be aware of?

> and that does in fact then allow attaching gdb to the userspace
> processes, but note that there's a process per mm, not per userspace
> thread, and thread switching happens by running something else in the
> mm. So effectively, you're actually debugging all the threads of an
> application, everything that runs in a single mm, all together.

According to the cover letter, this could be an answer to the "is
exec still slow" question I posted earlier. Very cool!

> 
> It's still really nice because you can actually use gdb to look at the
> lower-level internals of UML, but as I said, not quite working yet.
> 
> johannes
> 

Thanks for the heads up!
Glenn

[1] http://lists.infradead.org/pipermail/linux-um/2021-March/001167.html


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

