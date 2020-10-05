Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from hqnvemgate25.nvidia.com ([216.228.121.64])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPPzx-0005KK-Gv
 for linux-um@lists.infradead.org; Mon, 05 Oct 2020 12:53:51 +0000
Date: Mon, 5 Oct 2020 09:52:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/2] mmap locking API: Order lock of nascent mm outside
 lock of live mm
Message-ID: <20201005125216.GV816047@nvidia.com>
References: <CAG48ez1+ok5c5PK4DjA6-rYkg9qPeKoRrJmc5jsGf=TZZbShJg@mail.gmail.com>
 <CAG48ez1kMuPUW8VKp=9=KDLVisa-zuqp+DbYjc=A-kGUi_ik3A@mail.gmail.com>
 <CANN689H9hXzaV0_vpFfrvjQD6xAEaPnjok_17zWGHumRNs-ZWg@mail.gmail.com>
 <CAG48ez2LdreJtHcZBL=t010PghjVECcsat2e2kzgakDvR0ue5w@mail.gmail.com>
 <CANN689H6fQkSXL8U0M-MoSrw8b8cQFMDaTRKr2v8oacZJ_FhKA@mail.gmail.com>
 <CAG48ez0LuG9nULaBF_3ofE--u=TBgbxVdACthpb8wtJhADO02w@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAG48ez0LuG9nULaBF_3ofE--u=TBgbxVdACthpb8wtJhADO02w@mail.gmail.com>
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
To: Jann Horn <jannh@google.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Mon, Oct 05, 2020 at 03:30:43AM +0200, Jann Horn wrote:
> But another place where lockdep asserts should be added is find_vma();
> there are currently several architectures that sometimes improperly
> call that with no lock held:

Yes, I've seen several cases of this mis-use in drivers too

Jason

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

