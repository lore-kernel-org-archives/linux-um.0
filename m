Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12A3CCD19A
	for <linux-um@archiver.kernel.org>; Fri, 17 Oct 2025 08:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:From:Cc:To:Subject:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=oL6CGum7U6y7VC981LkHoeUdZajRgfZcn9dkk7SevwQ=; b=hFmRXCMgGsIZrtemUwcS/c9d13
	Hz5IpFR28oRWucA9N7I2jmdy1NcZtUgXaoF0hOhk06cI3p6dkpMceshJigs+Uz2syVZnpcY4TZ3o7
	ezQ+q3HCZLs8+Asvu3EVx88Mn71BsJgNZsu0WX9qukrGSSh+xrw/f3QPCuGMVUNnEL44SWB+1JCIP
	ZuxVVfw4bIWfYQgiY5SKRSA7vcSFXuZSHbX5QYKBUKsq17f27n+/xxohf/vWt7vM2F18wzCSRE/Oz
	dkd4AKWoQEai65E5XI8HsjTyH7R8YIWL1QAiPSCcK7MOgrtwHRW7DBnj6f5DlUUBVNzxt/2y5zXhj
	In3Do+9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9fe1-000000073VA-2pbw;
	Fri, 17 Oct 2025 08:17:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9fdx-000000073SN-2o00;
	Fri, 17 Oct 2025 08:16:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C4B1B6429A;
	Fri, 17 Oct 2025 08:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECFBC19421;
	Fri, 17 Oct 2025 08:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760689016;
	bh=/nupFfiBDTK8f3z19X5zBCAoNMhBKwg/9yA8JDj7YJ8=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=ekUis2qS/K43Wa3oMb6pzVrmzyh0OGl14tcBxht+kGV+lez/llzNd0s9mNO0RzixN
	 Q75JOdhNNo5UNgwXRxdAmWUi1TmKQfgq+e5PzKWDXtyivWCST/OSYnWJkfXMnb/O0F
	 bWFd3BTr2YRTDY2ZsyW9T5wO/yvIT9f9cT9MABvo=
Subject: Patch "minmax.h: update some comments" has been added to the 5.15-stable tree
To: David.Laight@ACULAB.COM,Jason@zx2c4.com,adilger.kernel@dilger.ca,agk@redhat.com,airlied@linux.ie,akpm@linux-foundation.org,amd-gfx@lists.freedesktop.org,andriy.shevchenko@linux.intel.com,anton.ivanov@cambridgegreys.com,arnd@kernel.org,axboe@kernel.dk,bp@alien8.de,clm@fb.com,coreteam@netfilter.org,dan.carpenter@linaro.org,daniel@ffwll.ch,dave.hansen@linux.intel.com,davem@davemloft.net,david.laight@aculab.com,dm-devel@redhat.com,dmitry.torokhov@gmail.com,dri-devel@lists.freedesktop.org,dsahern@kernel.org,dsterba@suse.com,dushistov@mail.ru,farbere@amazon.com,freedreno@lists.freedesktop.org,fw@strlen.de,gregkh@linuxfoundation.org,hch@infradead.org,hdegoede@redhat.com,herve.codina@bootlin.com,hpa@zytor.com,jack@suse.com,james.morse@arm.com,jdelvare@suse.com,jdike@addtoit.com,jejb@linux.ibm.com,jernej.skrabec@gmail.com,jmaloy@redhat.com,josef@toxicpanda.com,kadlec@netfilter.org,krzysztof.kozlowski@canonical.com,kuba@kernel.org,linus.walleij@linaro.org,linux-arm-kernel@lists.infradead.o
 rg,linux-mm@kvack.org,linux-staging@lists.linux.dev,linux-stm32@st-md-mailman.stormreply.com,linux-sunxi@lists.linux.dev,linux-um@lists.infradead.org,linux@rasmusvillemoes.dk,linux@roeck-us.net,lorenzo.stoakes@oracle.com,luc.vanoostenryck@gmail.com,luto@kernel.org,maarten.lankhorst@linux.intel.com,malattia@linux.it,martin.petersen@oracle.com,maz@kernel.org,mcoquelin.stm32@gmail.com,mgross@linux.intel.com,minchan@kernel.org,mingo@redhat.com,mjguzik@gmail.com,mripard@kernel.org,ngupta@vflare.org,pablo@netfilter.org,pedro.falcato@gmail.com,peterz@infradead.org,pmladek@suse.com,qiuxu.zhuo@intel.com,quic_akhilpo@quicinc.com,richard@nod.at,robdclark@gmail.com,rostedt@goodmis.org,rric@kernel.org,ruanjinjie@huawei.com,sakari.ailus@linux.intel.com,sashal@kernel.org,sean@poorly.run,senozhatsky@chromium.org,shuah@kernel.org,snitzer@redhat.com,tglx@linutronix.de,tipc-discussion@lists.sourceforge.net,tony.luck@intel.com,tytso@mit.edu,tzimmermann@suse.de,wens@csie.org,willy@infradead.org,x86@kern
 el.org,ying.xue@windriver.com,yoshfuji@linux-ipv6.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 17 Oct 2025 10:16:20 +0200
In-Reply-To: <20251008152946.29285-15-farbere@amazon.com>
Message-ID: <2025101720-splashed-matriarch-b59d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org


This is a note to let you know that I've just added the patch titled

    minmax.h: update some comments

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     minmax.h-update-some-comments.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From prvs=36971892a=farbere@amazon.com Wed Oct  8 17:34:21 2025
From: Eliav Farber <farbere@amazon.com>
Date: Wed, 8 Oct 2025 15:29:39 +0000
Subject: minmax.h: update some comments
To: <gregkh@linuxfoundation.org>, <jdike@addtoit.com>, <richard@nod.at>, <anton.ivanov@cambridgegreys.com>, <dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>, <tony.luck@intel.com>, <qiuxu.zhuo@intel.com>, <james.morse@arm.com>, <rric@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>, <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, <tzimmermann@suse.de>, <robdclark@gmail.com>, <sean@poorly.run>, <jdelvare@suse.com>, <linux@roeck-us.net>, <linus.walleij@linaro.org>, <dmitry.torokhov@gmail.com>, <maz@kernel.org>, <wens@csie.org>, <jernej.skrabec@gmail.com>, <agk@redhat.com>, <snitzer@redhat.com>, <dm-devel@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>, <mcoquelin.stm32@gmail.com>, <krzysztof.kozlowski@canonical.com>, <malattia@linux.it>, <hdegoede@redhat.com>, <mgross@linux.intel.com>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <sakari.ailus@l
 inux.intel.com>, <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <dushistov@mail.ru>, <luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <pmladek@suse.com>, <senozhatsky@chromium.org>, <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>, <minchan@kernel.org>, <ngupta@vflare.org>, <akpm@linux-foundation.org>, <yoshfuji@linux-ipv6.org>, <dsahern@kernel.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>, <fw@strlen.de>, <jmaloy@redhat.com>, <ying.xue@windriver.com>, <shuah@kernel.org>, <willy@infradead.org>, <farbere@amazon.com>, <sashal@kernel.org>, <quic_akhilpo@quicinc.com>, <ruanjinjie@huawei.com>, <David.Laight@ACULAB.COM>, <herve.codina@bootlin.com>, <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <linux-um@lists.infradead.org>, <linux-edac@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>, <freedreno@l
 ists.freedesktop.org>, <linux-hwmon@vger.kernel.org>, <linux-input@vger.kernel.org>, <linux-sunxi@lists.linux.dev>, <linux-media@vger.kernel.org>, <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>, <platform-driver-x86@vger.kernel.org>, <linux-scsi@vger.kernel.org>, <linux-staging@lists.linux.dev>, <linux-btrfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>, <linux-sparse@vger.kernel.org>, <linux-mm@kvack.org>, <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>, <tipc-discussion@lists.sourceforge.net>, <linux-kselftest@vger.kernel.org>, <stable@vger.kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Jens Axboe <axboe@kernel.dk>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, "Pedro Falcato" <pedro.falcato@gmail.com>
Message-ID: <20251008152946.29285-15-farbere@amazon.com>

From: David Laight <David.Laight@ACULAB.COM>

[ Upstream commit 10666e99204818ef45c702469488353b5bb09ec7 ]

- Change three to several.
- Remove the comment about retaining constant expressions, no longer true.
- Realign to nearer 80 columns and break on major punctiation.
- Add a leading comment to the block before __signed_type() and __is_nonneg()
  Otherwise the block explaining the cast is a bit 'floating'.
  Reword the rest of that comment to improve readability.

Link: https://lkml.kernel.org/r/85b050c81c1d4076aeb91a6cded45fee@AcuMS.aculab.com
Signed-off-by: David Laight <david.laight@aculab.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/minmax.h |   61 ++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -8,13 +8,10 @@
 #include <linux/types.h>
 
 /*
- * min()/max()/clamp() macros must accomplish three things:
+ * min()/max()/clamp() macros must accomplish several things:
  *
  * - Avoid multiple evaluations of the arguments (so side-effects like
  *   "x++" happen only once) when non-constant.
- * - Retain result as a constant expressions when called with only
- *   constant expressions (to avoid tripping VLA warnings in stack
- *   allocation usage).
  * - Perform signed v unsigned type-checking (to generate compile
  *   errors instead of nasty runtime surprises).
  * - Unsigned char/short are always promoted to signed int and can be
@@ -31,25 +28,23 @@
  *   bit #0 set if ok for unsigned comparisons
  *   bit #1 set if ok for signed comparisons
  *
- * In particular, statically non-negative signed integer
- * expressions are ok for both.
+ * In particular, statically non-negative signed integer expressions
+ * are ok for both.
  *
- * NOTE! Unsigned types smaller than 'int' are implicitly
- * converted to 'int' in expressions, and are accepted for
- * signed conversions for now. This is debatable.
- *
- * Note that 'x' is the original expression, and 'ux' is
- * the unique variable that contains the value.
- *
- * We use 'ux' for pure type checking, and 'x' for when
- * we need to look at the value (but without evaluating
- * it for side effects! Careful to only ever evaluate it
- * with sizeof() or __builtin_constant_p() etc).
- *
- * Pointers end up being checked by the normal C type
- * rules at the actual comparison, and these expressions
- * only need to be careful to not cause warnings for
- * pointer use.
+ * NOTE! Unsigned types smaller than 'int' are implicitly converted to 'int'
+ * in expressions, and are accepted for signed conversions for now.
+ * This is debatable.
+ *
+ * Note that 'x' is the original expression, and 'ux' is the unique variable
+ * that contains the value.
+ *
+ * We use 'ux' for pure type checking, and 'x' for when we need to look at the
+ * value (but without evaluating it for side effects!
+ * Careful to only ever evaluate it with sizeof() or __builtin_constant_p() etc).
+ *
+ * Pointers end up being checked by the normal C type rules at the actual
+ * comparison, and these expressions only need to be careful to not cause
+ * warnings for pointer use.
  */
 #define __signed_type_use(x, ux) (2 + __is_nonneg(x, ux))
 #define __unsigned_type_use(x, ux) (1 + 2 * (sizeof(ux) < 4))
@@ -57,19 +52,19 @@
 	__signed_type_use(x, ux) : __unsigned_type_use(x, ux))
 
 /*
- * To avoid warnings about casting pointers to integers
- * of different sizes, we need that special sign type.
+ * Check whether a signed value is always non-negative.
  *
- * On 64-bit we can just always use 'long', since any
- * integer or pointer type can just be cast to that.
+ * A cast is needed to avoid any warnings from values that aren't signed
+ * integer types (in which case the result doesn't matter).
  *
- * This does not work for 128-bit signed integers since
- * the cast would truncate them, but we do not use s128
- * types in the kernel (we do use 'u128', but they will
- * be handled by the !is_signed_type() case).
- *
- * NOTE! The cast is there only to avoid any warnings
- * from when values that aren't signed integer types.
+ * On 64-bit any integer or pointer type can safely be cast to 'long'.
+ * But on 32-bit we need to avoid warnings about casting pointers to integers
+ * of different sizes without truncating 64-bit values so 'long' or 'long long'
+ * must be used depending on the size of the value.
+ *
+ * This does not work for 128-bit signed integers since the cast would truncate
+ * them, but we do not use s128 types in the kernel (we do use 'u128',
+ * but they are handled by the !is_signed_type() case).
  */
 #ifdef CONFIG_64BIT
   #define __signed_type(ux) long


Patches currently in stable-queue which might be from farbere@amazon.com are

queue-5.15/minmax-add-a-few-more-min_t-max_t-users.patch
queue-5.15/minmax-improve-macro-expansion-and-type-checking.patch
queue-5.15/minmax-fix-indentation-of-__cmp_once-and-__clamp_once.patch
queue-5.15/minmax.h-simplify-the-variants-of-clamp.patch
queue-5.15/minmax-add-in_range-macro.patch
queue-5.15/minmax.h-move-all-the-clamp-definitions-after-the-min-max-ones.patch
queue-5.15/minmax-don-t-use-max-in-situations-that-want-a-c-constant-expression.patch
queue-5.15/minmax.h-remove-some-defines-that-are-only-expanded-once.patch
queue-5.15/minmax.h-use-build_bug_on_msg-for-the-lo-hi-test-in-clamp.patch
queue-5.15/minmax-simplify-min-max-clamp-implementation.patch
queue-5.15/minmax-deduplicate-__unconst_integer_typeof.patch
queue-5.15/minmax-simplify-and-clarify-min_t-max_t-implementation.patch
queue-5.15/minmax.h-add-whitespace-around-operators-and-after-commas.patch
queue-5.15/minmax-avoid-overly-complicated-constant-expressions-in-vm-code.patch
queue-5.15/minmax-make-generic-min-and-max-macros-available-everywhere.patch
queue-5.15/minmax-fix-up-min3-and-max3-too.patch
queue-5.15/minmax.h-reduce-the-define-expansion-of-min-max-and-clamp.patch
queue-5.15/minmax-introduce-min-max-_array.patch
queue-5.15/minmax.h-update-some-comments.patch

