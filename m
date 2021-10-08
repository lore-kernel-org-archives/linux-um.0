Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYuqj-003tUf-TM
 for linux-um@lists.infradead.org; Fri, 08 Oct 2021 18:44:07 +0000
Message-ID: <6aa90fcd1d262b9d963acd161e1afe2d6f9d6a6d.camel@sipsolutions.net>
Subject: Re: Using GDB to debug a user space process in UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 08 Oct 2021 20:43:59 +0200
In-Reply-To: <20211008114605.1071e36d@crass-HP-ZBook-15-G2>
References: <20211007013601.45fa8947@crass-HP-ZBook-15-G2>
 <CABqSeAQgYiBq7USUkb-fPZkXi6rtYeew_u1Gwg4Uxp9J3=NxsQ@mail.gmail.com>
 <20211008114605.1071e36d@crass-HP-ZBook-15-G2>
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
To: development@efficientek.com, YiFei Zhu <zhuyifei1999@gmail.com>
Cc: linux-um <linux-um@lists.infradead.org>

On Fri, 2021-10-08 at 11:46 -0500, Glenn Washburn wrote:
> 
> Another idea, that might be easier and maybe there's ideas on how this
> can be done without code changes, is to have the user-space process
> coredump on the host. I've enabled codedumps for the UML process, but
> they don't seem to contain the user-space processes. Probably because
> the user-space processes are not threads, but actually separate
> processes (or am I wrong about that?).

I don't think it's really all that simple.

A host process that UML creates corresponds to an *mm*, basically
virtual address space. This will often be a set of processes created
using clone(CLONE_VM), such as threads.

Also, a crash of a userspace process inside UML, such as via a segfault,
does not result in a crash of the UML process that's encapsulating that
process's mm, and in fact not even necessarily results in the
destruction of that mm, if e.g. other threads continue running.

What UML does then is switch around the actual threads inside those mm
processes whenever the scheduler decides which one should run. All those
mm processes are also around all at the same time, but only one of them
will ever be executing at a time (since UML is currently non-SMP).

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

