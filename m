Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lN0B8-0062m3-5r
 for linux-um@lists.infradead.org; Thu, 18 Mar 2021 21:27:40 +0000
Received: by mail-pj1-x1030.google.com with SMTP id
 nh23-20020a17090b3657b02900c0d5e235a8so3817260pjb.0
 for <linux-um@lists.infradead.org>; Thu, 18 Mar 2021 14:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210312095526.197739-1-johannes@sipsolutions.net>
 <20210312104627.927fb4c7d36f.Idb980393c41c2129ee592de4ed71e7a5518212f9@changeid>
In-Reply-To: <20210312104627.927fb4c7d36f.Idb980393c41c2129ee592de4ed71e7a5518212f9@changeid>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 18 Mar 2021 14:27:24 -0700
Message-ID: <CAFd5g47uR=HxjVET3uygeND8tFsZtfkgsS-PjMagbcagPMTBEg@mail.gmail.com>
Subject: Re: [PATCH 4/6] um: split up CONFIG_GCOV
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, Jessica Yu <jeyu@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Johannes Berg <johannes.berg@intel.com>

On Fri, Mar 12, 2021 at 1:56 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> It's not always desirable to collect coverage data for the
> entire kernel, so split off CONFIG_GCOV_BASE. This option
> only enables linking with coverage options, and compiles a
> single file (reboot.c) with them as well to force gcov to
> be linked into the kernel binary. That way, modules also
> work.
>
> To use this new option properly, one needs to manually add
> '-fprofile-arcs -ftest-coverage' to the compiler options
> of some object(s) or subdir(s) to collect coverage data at
> the desired places.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Hey, thanks for doing this! I was looking into this a few weeks ago
and root caused part of the issue in GCC and in the kernel, but I did
not have a fix put together.

Anyway, most of the patches make sense to me, but I am not able to
apply this patch on torvalds/master. Do you mind sending a rebase so I
can test it?

Thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

