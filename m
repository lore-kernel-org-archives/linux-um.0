Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYYsn-000ZNO-He
 for linux-um@lists.infradead.org; Thu, 07 Oct 2021 19:16:48 +0000
Message-ID: <aeac5d6ec9a59becbe84be6484bb312b216045ad.camel@sipsolutions.net>
Subject: Re: Using GDB to debug a user space process in UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 07 Oct 2021 21:16:40 +0200
In-Reply-To: <CABqSeAQgYiBq7USUkb-fPZkXi6rtYeew_u1Gwg4Uxp9J3=NxsQ@mail.gmail.com>
References: <20211007013601.45fa8947@crass-HP-ZBook-15-G2>
 <CABqSeAQgYiBq7USUkb-fPZkXi6rtYeew_u1Gwg4Uxp9J3=NxsQ@mail.gmail.com>
MIME-Version: 1.0
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
To: YiFei Zhu <zhuyifei1999@gmail.com>, development@efficientek.com
Cc: linux-um <linux-um@lists.infradead.org>

On Thu, 2021-10-07 at 11:41 -0700, YiFei Zhu wrote:
> On Wed, Oct 6, 2021 at 11:36 PM Glenn Washburn
> <development@efficientek.com> wrote:
> > 
> > I'm trying to debug a crash in busybox while it is the init process in
> > a UML instance. I'm having trouble breaking on the entry point of the
> > busybox binary. I'm pretty new to this space, so I'm proceeding from a
> > lot of ignorance, please correct me where I'm wrong and help me clear
> > up some things.
> 
> AFAIK, that isn't possible, but not because of address space
> translation, but because UML is already ptracing user space threads.

Indeed.

My brother posted some (incomplete and not entirely working yet) patches
recently here on the list to allow not using ptrace but seccomp instead,
and that does in fact then allow attaching gdb to the userspace
processes, but note that there's a process per mm, not per userspace
thread, and thread switching happens by running something else in the
mm. So effectively, you're actually debugging all the threads of an
application, everything that runs in a single mm, all together.

It's still really nice because you can actually use gdb to look at the
lower-level internals of UML, but as I said, not quite working yet.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

