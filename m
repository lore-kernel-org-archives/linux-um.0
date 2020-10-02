Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOJPk-0003hp-RH
 for linux-um@lists.infradead.org; Fri, 02 Oct 2020 11:39:53 +0000
Received: by mail-qv1-xf44.google.com with SMTP id b13so584743qvl.2
 for <linux-um@lists.infradead.org>; Fri, 02 Oct 2020 04:39:47 -0700 (PDT)
Date: Fri, 2 Oct 2020 08:39:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 1/2] mmap locking API: Order lock of nascent mm outside
 lock of live mm
Message-ID: <20201002113944.GH9916@ziepe.ca>
References: <CAG48ez1+ok5c5PK4DjA6-rYkg9qPeKoRrJmc5jsGf=TZZbShJg@mail.gmail.com>
 <CAG48ez1kMuPUW8VKp=9=KDLVisa-zuqp+DbYjc=A-kGUi_ik3A@mail.gmail.com>
 <CANN689H9hXzaV0_vpFfrvjQD6xAEaPnjok_17zWGHumRNs-ZWg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANN689H9hXzaV0_vpFfrvjQD6xAEaPnjok_17zWGHumRNs-ZWg@mail.gmail.com>
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
To: Michel Lespinasse <walken@google.com>
Cc: Jann Horn <jannh@google.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Fri, Oct 02, 2020 at 02:17:49AM -0700, Michel Lespinasse wrote:
> Also FYI I was going to play with these patches a bit to help answer
> these questions on my own, but wasn't able to easily apply them as
> they came lightly mangled (whitespace issues) when I saved them.

Me too

It seems OK, you've created sort of a SINGLE_DEPTH_NESTING but in
reverse - instead of marking the child of the nest it marks the
parent.

It would be nice to add a note in the commit message where the nesting
happens on this path.

Thanks,
Jason

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

