Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19C7CCA476
	for <linux-um@archiver.kernel.org>; Mon,  6 Oct 2025 12:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:From:Cc:To:Subject:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=r+yfnouGAxJLMxX7PYNWLinKX2hTrrnX1JjuNMojpG4=; b=H1IS393ssgQQE72cqe6dmAfoQz
	JwnEfPPNj7HhjeotJJU4wSQA3YAMxX7F0TTKK6v9Ri1//GxBCuS9CG85YYBh8WAttc3hMoL06Z8OS
	J7lpJhEh8vxQ6d17lozz6kSDym9oxaOPqA7aNAyQI83wJI4817oCf6qwzfDizVE9z/j677h4dbUGp
	5ff8/Ob0c6/6g3eOBsLXoFCpLJI8SezG5ljnGv1whM7oYDhYXQ8yA3XjNbsgXZ0ls7yrqD+SbobfM
	e2iH/Ni8ObGhgLx0HOnebzn1eSltVuv//fD+ILkvFUGrrGZmD0FhqAniDS5vVnDdO0tt0eTltrOeF
	zZ786Cmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5k9G-0000000HZqk-2hV4;
	Mon, 06 Oct 2025 12:17:02 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3EEj-00000002a8W-3njF;
	Mon, 29 Sep 2025 13:48:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1529462515;
	Mon, 29 Sep 2025 13:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1B0C4CEF4;
	Mon, 29 Sep 2025 13:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759153696;
	bh=FRCZRfk0/9Y0TgXFpLHgUktrJCsdSngcjZYfOD5xZeQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=B6t+Jrd3GyamU4Ar7VX528fTEGPw8TfIGLU+v86PgGuTdJBU5fURzBfMtrPPpNBHn
	 VBRNmAsDrb0Y9aUYk8ilRuUzMH87bN+auTdiVcj9Ry/18znhvhzzhca51CuLTEUIdH
	 keAbfTPJvzLrltacoycIYTVEGViEsKeEmZ5Er910=
Subject: Patch "minmax: Introduce {min,max}_array()" has been added to the 6.1-stable tree
To: David.Laight@ACULAB.COM,Rodrigo.Siqueira@amd.com,Xinhui.Pan@amd.com,adilger.kernel@dilger.ca,agk@redhat.com,airlied@gmail.com,akpm@linux-foundation.org,alexander.deucher@amd.com,alexandre.torgue@foss.st.com,amd-gfx@lists.freedesktop.org,andrii@kernel.org,andriy.shevchenko@linux.intel.com,andy.shevchenko@gmail.com,anton.ivanov@cambridgegreys.com,artur.paszkiewicz@intel.com,ast@kernel.org,bp@alien8.de,brian.starkey@arm.com,broonie@kernel.org,christian.koenig@amd.com,christophe.leroy@csgroup.eu,clm@fb.com,coreteam@netfilter.org,daniel@ffwll.ch,daniel@iogearbox.net,dave.hansen@linux.intel.com,davem@davemloft.net,dm-devel@redhat.com,dmitry.baryshkov@linaro.org,dmitry.torokhov@gmail.com,dri-devel@lists.freedesktop.org,dsahern@kernel.org,dsterba@suse.com,dushistov@mail.ru,edumazet@google.com,evan.quan@amd.com,farbere@amazon.com,fei1.li@intel.com,freedreno@lists.freedesktop.org,fw@strlen.de,gregkh@linuxfoundation.org,haoluo@google.com,harry.wentland@amd.com,hdegoede@redhat.com,herve.codi
 na@bootlin.com,hpa@zytor.com,jack@suse.com,james.morse@arm.com,james.qian.wang@arm.com,jdelvare@suse.com,jejb@linux.ibm.com,jernej.skrabec@gmail.com,jmaloy@redhat.com,joabreu@synopsys.com,johannes@sipsolutions.net,john.fastabend@gmail.com,jolsa@kernel.org,josef@toxicpanda.com,kadlec@netfilter.org,keescook@chromium.org,kpsingh@kernel.org,krzysztof.kozlowski@linaro.org,kuba@kernel.org,linus.walleij@linaro.org,linux-arm-kernel@lists.infradead.org,linux-mm@kvack.org,linux-staging@lists.linux.dev,linux-stm32@st-md-mailman.stormreply.com,linux-sunxi@lists.linux.dev,linux-um@lists.infradead.org,linux@armlinux.org.uk,linux@rasmusvillemoes.dk,linux@roeck-us.net,liviu.dudau@arm.com,luc.vanoostenryck@gmail.com,luto@kernel.org,maarten.lankhorst@linux.intel.com,malattia@linux.it,markgross@kernel.org,martin.lau@linux.dev,martin.petersen@oracle.com,maz@kernel.org,mchehab@kernel.org,mcoquelin.stm32@gmail.com,mhiramat@kernel.org,mihail.atanassov@arm.com,minchan@kernel.org,mingo@redhat.com,mripard@ke
 rnel.org,mykolal@fb.com,ngupta@vflare.org,pabeni@redhat.com,pablo@netfilter.org,peppe.cavallaro@st.com,peterz@infradead.org,pmladek@suse.com,qiuxu.zhuo@intel.com,quic_abhinavk@quicinc.com,quic_akhilpo@quicinc.com,rajur@chelsio.com,richard@nod.at,robdclark@gmail.com,rostedt@goodmis.org,rric@kernel.org,ruanjinjie@huawei.com,sakari.ailus@linux.intel.com,samuel@sholland.org,sashal@kernel.org,sdf@google.com,sean@poorly.run,senozhatsky@chromium.org,shuah@kernel.org,snitzer@kernel.org,song@kernel.org,sunpeng.li@amd.com,tglx@linutronix.de,tipc-discussion@lists.sourceforge.net,tony.luck@intel.com,tytso@mit.edu,tzimmermann@suse.de,wad@chromium.org,wens@csie.org,willy@infradead.org,x86@kernel.org,yhs@fb.com,ying.xue@windriver.com,yoshfuji@linux-ipv6.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Sep 2025 15:47:51 +0200
In-Reply-To: <20250924202320.32333-3-farbere@amazon.com>
Message-ID: <2025092950-unwritten-skittle-230c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Mailman-Approved-At: Mon, 06 Oct 2025 05:16:25 -0700
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

    minmax: Introduce {min,max}_array()

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     minmax-introduce-min-max-_array.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From prvs=3555e8f33=farbere@amazon.com Wed Sep 24 22:25:22 2025
From: Eliav Farber <farbere@amazon.com>
Date: Wed, 24 Sep 2025 20:23:03 +0000
Subject: minmax: Introduce {min,max}_array()
To: <linux@armlinux.org.uk>, <richard@nod.at>, <anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>, <dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>, <tony.luck@intel.com>, <qiuxu.zhuo@intel.com>, <mchehab@kernel.org>, <james.morse@arm.com>, <rric@kernel.org>, <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <Rodrigo.Siqueira@amd.com>, <alexander.deucher@amd.com>, <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>, <evan.quan@amd.com>, <james.qian.wang@arm.com>, <liviu.dudau@arm.com>, <mihail.atanassov@arm.com>, <brian.starkey@arm.com>, <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, <tzimmermann@suse.de>, <robdclark@gmail.com>, <quic_abhinavk@quicinc.com>, <dmitry.baryshkov@linaro.org>, <sean@poorly.run>, <jdelvare@suse.com>, <linux@roeck-us.net>, <linus.walleij@linaro.org>, <dmitry.torokhov@gmail.com>, <maz@k
 ernel.org>, <wens@csie.org>, <jernej.skrabec@gmail.com>, <samuel@sholland.org>, <agk@redhat.com>, <snitzer@kernel.org>, <dm-devel@redhat.com>, <rajur@chelsio.com>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <peppe.cavallaro@st.com>, <alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <krzysztof.kozlowski@linaro.org>, <malattia@linux.it>, <hdegoede@redhat.com>, <markgross@kernel.org>, <artur.paszkiewicz@intel.com>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <sakari.ailus@linux.intel.com>, <gregkh@linuxfoundation.org>, <fei1.li@intel.com>, <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <dushistov@mail.ru>, <luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <mhiramat@kernel.org>, <pmladek@suse.com>, <senozhatsky@chromium.org>, <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>, <minchan@kernel.org>, <ngupta@vflare.
 org>, <akpm@linux-foundation.org>, <yoshfuji@linux-ipv6.org>, <dsahern@kernel.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>, <fw@strlen.de>, <jmaloy@redhat.com>, <ying.xue@windriver.com>, <andrii@kernel.org>, <mykolal@fb.com>, <ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>, <shuah@kernel.org>, <keescook@chromium.org>, <wad@chromium.org>, <willy@infradead.org>, <farbere@amazon.com>, <sashal@kernel.org>, <ruanjinjie@huawei.com>, <quic_akhilpo@quicinc.com>, <David.Laight@ACULAB.COM>, <herve.codina@bootlin.com>, <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <linux-um@lists.infradead.org>, <linux-edac@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>, <linux-hwmon@vger.kernel.org>, <linux-input@vge
 r.kernel.org>, <linux-sunxi@lists.linux.dev>, <linux-media@vger.kernel.org>, <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>, <platform-driver-x86@vger.kernel.org>, <linux-scsi@vger.kernel.org>, <linux-staging@lists.linux.dev>, <linux-btrfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>, <linux-sparse@vger.kernel.org>, <linux-mm@kvack.org>, <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>, <tipc-discussion@lists.sourceforge.net>, <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, <stable@vger.kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <20250924202320.32333-3-farbere@amazon.com>

From: Herve Codina <herve.codina@bootlin.com>

[ Upstream commit c952c748c7a983a8bda9112984e6f2c1f6e441a5 ]

Introduce min_array() (resp max_array()) in order to get the
minimal (resp maximum) of values present in an array.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://lore.kernel.org/r/20230623085830.749991-8-herve.codina@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/minmax.h |   64 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -168,6 +168,70 @@
  */
 #define max_t(type, x, y)	__careful_cmp(max, (type)(x), (type)(y))
 
+/*
+ * Remove a const qualifier from integer types
+ * _Generic(foo, type-name: association, ..., default: association) performs a
+ * comparison against the foo type (not the qualified type).
+ * Do not use the const keyword in the type-name as it will not match the
+ * unqualified type of foo.
+ */
+#define __unconst_integer_type_cases(type)	\
+	unsigned type:  (unsigned type)0,	\
+	signed type:    (signed type)0
+
+#define __unconst_integer_typeof(x) typeof(			\
+	_Generic((x),						\
+		char: (char)0,					\
+		__unconst_integer_type_cases(char),		\
+		__unconst_integer_type_cases(short),		\
+		__unconst_integer_type_cases(int),		\
+		__unconst_integer_type_cases(long),		\
+		__unconst_integer_type_cases(long long),	\
+		default: (x)))
+
+/*
+ * Do not check the array parameter using __must_be_array().
+ * In the following legit use-case where the "array" passed is a simple pointer,
+ * __must_be_array() will return a failure.
+ * --- 8< ---
+ * int *buff
+ * ...
+ * min = min_array(buff, nb_items);
+ * --- 8< ---
+ *
+ * The first typeof(&(array)[0]) is needed in order to support arrays of both
+ * 'int *buff' and 'int buff[N]' types.
+ *
+ * The array can be an array of const items.
+ * typeof() keeps the const qualifier. Use __unconst_integer_typeof() in order
+ * to discard the const qualifier for the __element variable.
+ */
+#define __minmax_array(op, array, len) ({				\
+	typeof(&(array)[0]) __array = (array);				\
+	typeof(len) __len = (len);					\
+	__unconst_integer_typeof(__array[0]) __element = __array[--__len]; \
+	while (__len--)							\
+		__element = op(__element, __array[__len]);		\
+	__element; })
+
+/**
+ * min_array - return minimum of values present in an array
+ * @array: array
+ * @len: array length
+ *
+ * Note that @len must not be zero (empty array).
+ */
+#define min_array(array, len) __minmax_array(min, array, len)
+
+/**
+ * max_array - return maximum of values present in an array
+ * @array: array
+ * @len: array length
+ *
+ * Note that @len must not be zero (empty array).
+ */
+#define max_array(array, len) __minmax_array(max, array, len)
+
 /**
  * clamp_t - return a value clamped to a given range using a given type
  * @type: the type of variable to use


Patches currently in stable-queue which might be from farbere@amazon.com are

queue-6.1/minmax-fix-indentation-of-__cmp_once-and-__clamp_once.patch
queue-6.1/minmax-add-in_range-macro.patch
queue-6.1/minmax-deduplicate-__unconst_integer_typeof.patch
queue-6.1/minmax-introduce-min-max-_array.patch

