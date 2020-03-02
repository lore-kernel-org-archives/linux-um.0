Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8r5z-0003g9-AW
 for linux-um@lists.infradead.org; Mon, 02 Mar 2020 19:51:20 +0000
Received: by mail-pj1-f67.google.com with SMTP id 12so232910pjb.5
 for <linux-um@lists.infradead.org>; Mon, 02 Mar 2020 11:51:18 -0800 (PST)
Date: Mon, 2 Mar 2020 19:51:16 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC v2 21/37] lkl tools: "boot" test
Message-ID: <20200302195116.GF11244@42.do-not-panic.com>
References: <fb0fcf4ffddaabc7eae82e25d7ec5ea9c37eb2ae.1573179553.git.thehajime@gmail.com>
 <20200123193315.132434-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200123193315.132434-1-brendanhiggins@google.com>
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: linux-arch@vger.kernel.org, Mark Stillwell <mark@stillwell.me>, Conrad Meyer <cem@FreeBSD.org>, Octavian Purdila <tavi.purdila@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Motomu Utsumi <motomuman@gmail.com>, linux-um@lists.infradead.org, Akira Moroo <retrage01@gmail.com>, Petros Angelatos <petrosagg@gmail.com>, Yuan Liu <liuyuan@google.com>, Aleksa Sarai <cyphar@cyphar.com>, linux-kernel-library@freelists.org, Thomas Liebetraut <thomas@tommie-lie.de>, David Gow <davidgow@google.com>, David Disseldorp <ddiss@suse.de>, Patrick Collins <pscollins@google.com>, Luca Dariz <luca.dariz@gmail.com>, Hajime Tazaki <thehajime@gmail.com>, kunit-dev@googlegroups.com

On Thu, Jan 23, 2020 at 11:33:15AM -0800, Brendan Higgins wrote:
> Luis,
> 
> Does this kind of match what you were thinking with the syscall testing?

Without looking too deeply into the code, it seems to be the case.
Are you going to expose / port kunit to tools/ to allow usersapace
to run kunit tests?

> In any case, I am excited about this. Please keep me posted in the
> future!

Yes please Cc me too.

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

