Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPMO2-0000nX-AV
 for linux-um@lists.infradead.org; Tue, 29 Oct 2019 07:57:55 +0000
Message-ID: <9df8075205912512a9a0ec7eb0393ff74d3c4bbb.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 03/47] lkl: architecture skeleton for Linux kernel
 library
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 29 Oct 2019 08:57:43 +0100
In-Reply-To: <m2a79k3tyf.wl-thehajime@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
 <0b1464dd4904ee2b049fef624895ead3fe6aa555.1571798507.git.thehajime@gmail.com>
 <CAFLxGvzqPzZtUSzymWgnhGnr6qgcDe9ue6Q8ALMS-r_Y+KXVOw@mail.gmail.com>
 <m2a79mx6br.wl-thehajime@gmail.com>
 <CAJhGHyBy4ok+Sg7TyLaaksqEBDanmZgsk6ujRqXU1KFcu+DHZQ@mail.gmail.com>
 <m2a79k3tyf.wl-thehajime@gmail.com>
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
To: Hajime Tazaki <thehajime@gmail.com>, jiangshanlai@gmail.com
Cc: levex@linux.com, mattator@gmail.com, cem@freebsd.org, richard.weinberger@gmail.com, liuyuan@google.com, staal1978@gmail.com, motomuman@gmail.com, linux-um@lists.infradead.org, retrage01@gmail.com, petrosagg@gmail.com, tavi.purdila@gmail.com, xiaoj@google.com, mark@stillwell.me, pscollins@google.com, phh@phh.me, sigmaepsilon92@gmail.com, luca.dariz@gmail.com, edisonmcastro@hotmail.com

Hi,

> You're right: current patchset only share Makefile(s)
> between UML and LKL.  This is the first step toward the
> unification in my plan, described in the milestone of the
> cover letter (copy-pasted below).
> 
> > Milestone
> > =========
> > (snip)
> > 1. Put LKL code under arch/um (arch/um/lkl), and build it in a
> > separate way from UML.
> > 2. Share common parts of implementation between UML and LKL.
> > 3. Reimplement UML features with LKL API (if we wish)
> 
> For the step 2, [PATCH 46/47] and [47/47] are the kind of
> examples for this level of unification (sorry for the very
> dirty code).
> 
> For the step 3, I don't have any WIP code nor detailed plan.
> Implementing ptrace-based (or similar) syscall interception
> would be one of the development (I believe there are more).
> 
> Offering UML feature-sets, keeping compatibility, while
> benefiting from LKL (e.g., various underlying environment
> support) would be very high-level goal since there are many
> users of UML (various test tool projects, including coming
> Kunit).

Aren't you going about this the wrong way around?

I mean, this reads like you're proposing to start from LKL and
reimplement UML on top of it, but we currently have UML in the tree and
LKL isn't. Seems backward to me.

Also, looking at the patches, I'm not a huge fan of the whole "drop LKL
into UML". UML is already complex enough as is, with its memory model
and all, mixing in LKL makes it way more complex.

I don't think "drop LKL under UML" was what people had in mind when they
suggested that the two merge ...

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

