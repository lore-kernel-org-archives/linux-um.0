Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8tVU-0003HT-BS
 for linux-um@lists.infradead.org; Mon, 02 Mar 2020 22:25:49 +0000
Received: by mail-pf1-x42f.google.com with SMTP id y5so390239pfb.11
 for <linux-um@lists.infradead.org>; Mon, 02 Mar 2020 14:25:47 -0800 (PST)
MIME-Version: 1.0
References: <fb0fcf4ffddaabc7eae82e25d7ec5ea9c37eb2ae.1573179553.git.thehajime@gmail.com>
 <20200123193315.132434-1-brendanhiggins@google.com>
 <20200302195116.GF11244@42.do-not-panic.com>
In-Reply-To: <20200302195116.GF11244@42.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 2 Mar 2020 14:25:35 -0800
Message-ID: <CAFd5g44+PD9FM6Vhy2uFAkSvgsOdxjy2gcP6duBzuhJGJaddgg@mail.gmail.com>
Subject: Re: [RFC v2 21/37] lkl tools: "boot" test
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
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-arch@vger.kernel.org, Mark Stillwell <mark@stillwell.me>, Conrad Meyer <cem@freebsd.org>, Octavian Purdila <tavi.purdila@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Motomu Utsumi <motomuman@gmail.com>, linux-um <linux-um@lists.infradead.org>, Akira Moroo <retrage01@gmail.com>, Petros Angelatos <petrosagg@gmail.com>, Yuan Liu <liuyuan@google.com>, Aleksa Sarai <cyphar@cyphar.com>, linux-kernel-library@freelists.org, Thomas Liebetraut <thomas@tommie-lie.de>, David Gow <davidgow@google.com>, David Disseldorp <ddiss@suse.de>, Patrick Collins <pscollins@google.com>, Luca Dariz <luca.dariz@gmail.com>, Hajime Tazaki <thehajime@gmail.com>, KUnit Development <kunit-dev@googlegroups.com>

On Mon, Mar 2, 2020 at 11:51 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Jan 23, 2020 at 11:33:15AM -0800, Brendan Higgins wrote:
> > Luis,
> >
> > Does this kind of match what you were thinking with the syscall testing?
>
> Without looking too deeply into the code, it seems to be the case.
> Are you going to expose / port kunit to tools/ to allow usersapace
> to run kunit tests?

Yes, I am thinking about this as a distinct possibility. I think it
only really makes sense in the context of syscall testing, probably
via LKL (assuming this works), but for general end-to-end testing, I
think kselftest has that area covered and users would be better served
by just integrating KUnit with kselftest.

> > In any case, I am excited about this. Please keep me posted in the
> > future!
>
> Yes please Cc me too.
>
>   Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

