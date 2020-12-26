Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ktIau-0000f7-2A
 for linux-um@lists.infradead.org; Sat, 26 Dec 2020 23:03:28 +0000
Received: by mail-qk1-x72e.google.com with SMTP id p14so6259480qke.6
 for <linux-um@lists.infradead.org>; Sat, 26 Dec 2020 15:03:25 -0800 (PST)
MIME-Version: 1.0
References: <080A3B31-608F-4A36-A5DE-B75670D2452E@icloud.com>
In-Reply-To: <080A3B31-608F-4A36-A5DE-B75670D2452E@icloud.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 27 Dec 2020 00:03:13 +0100
Message-ID: <CAFLxGvxVfLhfqxt8C1j_1V_oOpda_CE_s2QaHcv4hcZ2Euy_UA@mail.gmail.com>
Subject: Re: linux.git is broken on a case-insensitive filesystem
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
To: Theodore Dubois <tblodt@icloud.com>
Cc: linux-um <linux-um@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>

Theodore,

On Sat, Dec 26, 2020 at 11:41 PM Theodore Dubois <tblodt@icloud.com> wrote:
>
> I'm currently hacking on Linux trying to run a sort of UML-style thing on macOS (please don't question my sanity :), and I've run into various issues stemming from macOS having a case-insensitive filesystem.

Sounds interesting, if you have questions on UML internals, just ask.

> The one you run into immediately is: there are a number of files (mostly in netfilter) that have different uppercase and lowercase versions. net/netfilter/xt_DSCP.c and net/netfilter/xt_dscp.c are quite different. Last I checked, git would pseudo-randomly pick one of these to check out, and then show the other one as having unstaged changes making it look like the first one. This causes problems when switching branches. I've worked around this with a sparse checkout that excludes these files, but it's not great.
>
> The gitignore also contains the pattern *.s, which excludes *.S as well when git is ignoring case.
>
> Is there any interest in fixing these?

I fear it is a little more complicated.
We have different upper and lower case variants in include/uapi/. If
you rename them, existing programs
will fail to build.
...which will make users sad and Linus grumpy.

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

