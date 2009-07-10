Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1754194AbZGJItS@vger.kernel.org>
Date: Fri, 10 Jul 2009 16:51:08 +0800
From: Amerigo Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 17/44] includecheck fix: um, helper.c
Message-ID: <20090710085108.GD6263@cr0.nay.redhat.com>
References: <1247063308.4382.12.camel@ht.satnam> <1247064950.4382.45.camel@ht.satnam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1247064950.4382.45.camel@ht.satnam>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Jul 08, 2009 at 08:25:50PM +0530, Jaswinder Singh Rajput wrote:
>
>fix the following 'make includecheck' warning:
>
>  arch/um/os-Linux/helper.c: linux/limits.h is included more than once.
>
>Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
>---
> arch/um/os-Linux/helper.c |    1 -
> 1 files changed, 0 insertions(+), 1 deletions(-)
>
>diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
>index 30860b8..b6b1096 100644
>--- a/arch/um/os-Linux/helper.c
>+++ b/arch/um/os-Linux/helper.c
>@@ -15,7 +15,6 @@
> #include "os.h"
> #include "um_malloc.h"
> #include "user.h"
>-#include <linux/limits.h>
> 
> struct helper_data {
> 	void (*pre_exec)(void*);

Definitely yes.

Acked-by: WANG Cong <xiyou.wangcong@gmail.com>

