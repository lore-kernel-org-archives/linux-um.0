Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iO7Jh-0006UP-VC
 for linux-um@lists.infradead.org; Fri, 25 Oct 2019 21:40:19 +0000
Received: by mail-wm1-x341.google.com with SMTP id 22so3316702wms.3
 for <linux-um@lists.infradead.org>; Fri, 25 Oct 2019 14:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571798507.git.thehajime@gmail.com>
 <0b1464dd4904ee2b049fef624895ead3fe6aa555.1571798507.git.thehajime@gmail.com>
In-Reply-To: <0b1464dd4904ee2b049fef624895ead3fe6aa555.1571798507.git.thehajime@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 25 Oct 2019 23:40:05 +0200
Message-ID: <CAFLxGvzqPzZtUSzymWgnhGnr6qgcDe9ue6Q8ALMS-r_Y+KXVOw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/47] lkl: architecture skeleton for Linux kernel
 library
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: "H . K . Jerry Chu" <hkchu@google.com>, Levente Kurusa <levex@linux.com>, Matthieu Coudron <mattator@gmail.com>, Conrad Meyer <cem@freebsd.org>, Octavian Purdila <tavi.purdila@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Jens Staal <staal1978@gmail.com>, Motomu Utsumi <motomuman@gmail.com>, linux-um@lists.infradead.org, Akira Moroo <retrage01@gmail.com>, Petros Angelatos <petrosagg@gmail.com>, Andreas Abel <aabel@google.com>, Xiao Jia <xiaoj@google.com>, Mark Stillwell <mark@stillwell.me>, "Edison M . Castro" <edisonmcastro@hotmail.com>, Patrick Collins <pscollins@google.com>, Pierre-Hugues Husson <phh@phh.me>, Michael Zimmermann <sigmaepsilon92@gmail.com>, Luca Dariz <luca.dariz@gmail.com>, Yuan Liu <liuyuan@google.com>

On Wed, Oct 23, 2019 at 6:39 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
> +LINUX KERNEL LIBRARY
> +M:     Octavian Purdila <octavian.purdila@intel.com>
> +M:     Hajime Tazaki <thehajime@gmail.com>
> +L:     linux-kernel-library@freelists.org
> +S:     Maintained
> +F:     arch/lkl/
> +F:     tools/lkl/
> +

The arch/lkl path is outdated.
So, you and Octavian will maintain LKL?

Do you want to be sub maintainers of arch/um/lkl and send pull requests to me
or co-maintain the whole UML ecosystem together with me and Anton?

I'm perfectly fine with both variants but tend to the latter one since
it is less overhead.
In case you need your PGP keys signed, next week I'll be in Lyon at
OSS, ELCE, ...

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

