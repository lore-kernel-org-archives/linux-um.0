Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMX9h-003GF4-45
 for linux-um@lists.infradead.org; Wed, 17 Mar 2021 14:28:14 +0000
Message-ID: <3d3e446409d00dfbe62320832799d0a3b34b2b9c.camel@sipsolutions.net>
Subject: Re: [RFC v8 19/20] um: lkl: add block device support of UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 17 Mar 2021 15:28:10 +0100
In-Reply-To: <CAMoF9u2phDz5nmFFSW-9VKs2gTK0exHaPxrOf4nM5gAQnQhcRQ@mail.gmail.com>
 (sfid-20210317_152001_277313_6713C6E5)
References: <cover.1611103406.git.thehajime@gmail.com>
 <b3b73864dbb738d0de7c49a6df5a5f53a358ec93.1611103406.git.thehajime@gmail.com>
 <2b649bc5165c7ff4547abd72f7e03e7491980138.camel@sipsolutions.net>
 <m25z1rc2ux.wl-thehajime@gmail.com>
 <56af0e44c846f4b079256ec997c56119964be402.camel@sipsolutions.net>
 <CAMoF9u2phDz5nmFFSW-9VKs2gTK0exHaPxrOf4nM5gAQnQhcRQ@mail.gmail.com>
 (sfid-20210317_152001_277313_6713C6E5)
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
To: Octavian Purdila <tavi.purdila@gmail.com>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-kernel-library <linux-kernel-library@freelists.org>, linux-arch <linux-arch@vger.kernel.org>, Akira Moroo <retrage01@gmail.com>

On Wed, 2021-03-17 at 16:19 +0200, Octavian Purdila wrote:
> > I can understand that your sample code wants btrfs just to show what it
> > can do, but IMHO it doesn't make sense to *always* enable it.

Btw, what I said there also didn't distinguish between "always enable
it" and "always force it enabled".

Right now this patch did the latter, but the former might sort of make
sense, but would take the form of a defconfig rather than a Kconfig code
change.

> 
> I agree. I think these can stay in defconfigs but here is where a
> library introduces complications which I don't know how is best to
> handle. Should we have the defconfig in arch/um or should we have it
> in tools/testing/selftests/um? Or perhaps both places, one being a
> generic config that would be used by most applications and one
> customized?

Yeah, that's a question - and in that sense LKL will never be a general-
purpose "library" since then you'd have to basically build it with
"allyesconfig" instead of other things.

Maybe just put a note there with the tools, and maybe a defconfig, and
then have some kind of detection at example/tool build or even runtime
that the necessary options are selected?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

