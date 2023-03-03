Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FF5C678D4
	for <linux-um@archiver.kernel.org>; Fri,  3 Mar 2023 07:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:
	To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uEHEdlZAodUZr895N4xNmNl46QZwrH7YZ75dwJYsR9o=; b=AeToZubBs6z70mG/3L3ZYNZqpd
	tXODxqNxAUHRGnrrrb9FGWf5Gc7qNAfSToddO0YAkF8dNULo+wEixA1KLKv9iVXJxq5GxjWhZXSwb
	x1J6K2DnN7Pkqdg74FCTVLt0evzTsTLQuDsglMYyv949xcj1yLY9roki535+FFuMgRSgx8gykrDsJ
	uCgbKTXpzGQ4a9UjOM0TNogWb8ixwKbmwNZmHtf0A20dINZ9ELgojEyg3HT+NH4Yvw555W/cFa04p
	3FYunClSx1NjyorXBUqICeIos3TlgP9mKQwRSoTGz2OntDwS3+T6LVdZjJJho5bOu0+LJ3Ggg1mY5
	BrS/kqUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXzdq-005CxQ-Qw; Fri, 03 Mar 2023 07:15:46 +0000
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXzdn-005Cwu-OY
	for linux-um@lists.infradead.org; Fri, 03 Mar 2023 07:15:46 +0000
Received: by mail-ua1-x931.google.com with SMTP id g19so1029961ual.4
        for <linux-um@lists.infradead.org>; Thu, 02 Mar 2023 23:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677827743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e1AiBWt+JORYw/nWNhqhViEyzX1/XONbOa/JUdi6oqw=;
        b=eoSAAoQCECl8GZlzx6Iqt4ChknPGfP7+ZxvOEX5SPZdSVnq0TpkT+qZFfLbks3auUa
         DiYV24EBvCyBt9wvl2Mp4wyWsH54TLPZRhZUmRQC+KbjPr/WV+RpVywYiXLjm9p0Gr/6
         BIVA9rOZ7nVazZbjECI/Rvw8JhkGAXWueVwHS9zrKF3VsRhAecA1Zm/VPRIXrrzGmi9I
         PufZ/9BkUiQ5cn0vJOVp61mpofjmws936Y3HYYPTSHWB64JH2eZDlU7ANdFZ8Vq4CkNl
         NIHuwj4xTfUuYYJzPLzF1JrHlWC3aA1ahb9sWnC/fZ0KOlYAwBbc69jd3GmlQolvIvMw
         fkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677827743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1AiBWt+JORYw/nWNhqhViEyzX1/XONbOa/JUdi6oqw=;
        b=Gg0esmTm6C9JAcA/vIgvMhibC0xGmoC/C6Kq9Xkc8aKH1tBQErd/d1r/8RN1w7hhYM
         YcUlI0Pvc3gAuHZ4YiOGy+mbEp3u85kXl3L+EFOVj0paxpIzFjFog0NqDDIOn6qT5As8
         MMZOKKkJLjAoeoXH4zhbXnc8aHTz7SbVxwU3OdhPq10TFz1ni2ONW/CrKA2RmhtpToEM
         NoRcTX3eS6cjiX40QCzmns7oO/HKsuWwynuLS/DjoYrlWa+BtEp03dJeFFra22kTJvus
         4PcJRR/PDxM0m9mvKllmslGD7Ou4cfcnomEFSLxQRQ57Dyw72xATMvVi6tYc2Yu2ttH6
         IE+Q==
X-Gm-Message-State: AO0yUKXPjqjE7LVIdDweyb17AO2HTnPRwtQp+7Ke7+HVkSbg5C7sTtSw
	jmuFSPUmzzuU3vIbN8tnAcjm6PquWs6RuQGqE9FBcQ==
X-Google-Smtp-Source: AK7set/Pqmv1ghx7+0zKDz64Zr0G4YPBbAStvMbNIS+bp8f/xfqE+B82USlluiAEWmub1pjorXAwZ4PNOB1sHtvlIYk=
X-Received: by 2002:ab0:4a5a:0:b0:68b:716e:ed8a with SMTP id
 r26-20020ab04a5a000000b0068b716eed8amr514834uae.0.1677827742829; Thu, 02 Mar
 2023 23:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-4-sboyd@kernel.org>
In-Reply-To: <20230302013822.1808711-4-sboyd@kernel.org>
From: David Gow <davidgow@google.com>
Date: Fri, 3 Mar 2023 15:15:31 +0800
Message-ID: <CABVgOSmR0_u8Tw0E8C1mRFxSiGKwdKG5ka_+X_36Hj4VNLdg2g@mail.gmail.com>
Subject: Re: [PATCH 3/8] kunit: Add test managed platform_device/driver APIs
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	Brendan Higgins <brendan.higgins@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230302_231543_925156_EF933C3F 
X-CRM114-Status: GOOD (  42.02  )
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
Content-Type: multipart/mixed; boundary="===============4115147407437478544=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

--===============4115147407437478544==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a0c3e105f5f9b691"

--000000000000a0c3e105f5f9b691
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Introduce KUnit resource wrappers around platform_driver_register(),
> platform_device_alloc(), and platform_device_add() so that test authors
> can register platform drivers/devices from their tests and have the
> drivers/devices automatically be unregistered when the test is done.
>
> This makes test setup code simpler when a platform driver or platform
> device is needed. Add a few test cases at the same time to make sure the
> APIs work as intended.
>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>
> Should this be moved to drivers/base/ and called platform_kunit.c?
> The include/kunit/platform_driver.h could also be
> kunit/platform_device.h to match linux/platform_device.h if that is more
> familiar.

DRM has a similar thing already (albeit with a root_device, which is
more common with KUnit tests generally):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/drm/drm_kunit_helpers.h

But that's reasonably drm-specific, so it makes sense that it lives
with DRM stuff. platform_device is a bit more generic.

I'd probably personally err on the side of having these in
drivers/base/, as I think we'll ultimately need similar things for a
lot of different devices, and I'd rather not end up with things like
USB device helpers living in the lib/kunit directory alongside the
"core" KUnit code. But I could be persuaded otherwise.

>
> And I'm not super certain about allocating a driver structure and
> embedding it in a wrapper struct. Maybe the code should just use
> kunit_get_current_test() instead?

I think there are enough cases througout the kernel where
device/driver structs are needed that having this makes sense.
Combined with the fact that, while kunit_get_current_test() can be
used even when KUnit is not loaded, actually doing anything with the
resulting struct kunit pointer will probably require (at least for the
moment) KUnit functions to be reachable, so would break if
CONFIG_KUNIT=m.

So, unless you actually find kunit_get_current_test() and friends to
be easier to work with, I'd probably stick with this.

>
>  include/kunit/platform_driver.h  |  15 +++
>  lib/kunit/Makefile               |   6 +
>  lib/kunit/platform_driver-test.c | 107 ++++++++++++++++
>  lib/kunit/platform_driver.c      | 207 +++++++++++++++++++++++++++++++
>  4 files changed, 335 insertions(+)
>  create mode 100644 include/kunit/platform_driver.h
>  create mode 100644 lib/kunit/platform_driver-test.c
>  create mode 100644 lib/kunit/platform_driver.c
>
> diff --git a/include/kunit/platform_driver.h b/include/kunit/platform_driver.h
> new file mode 100644
> index 000000000000..dc211ff8f893
> --- /dev/null
> +++ b/include/kunit/platform_driver.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _KUNIT_PLATFORM_DRIVER_H
> +#define _KUNIT_PLATFORM_DRIVER_H
> +
> +struct kunit;
> +struct platform_device;
> +struct platform_driver;
> +
> +struct platform_device *
> +kunit_platform_device_alloc(struct kunit *test, const char *name, int id);
> +int kunit_platform_device_add(struct kunit *test, struct platform_device *pdev);
> +
> +int kunit_platform_driver_register(struct kunit *test, struct platform_driver *drv);
> +
> +#endif
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 29aff6562b42..5964d8231ff5 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_KUNIT) +=                 kunit.o
>
> +# Core KUnit code
>  kunit-objs +=                          test.o \
>                                         resource.o \
>                                         string-stream.o \
> @@ -11,7 +12,12 @@ ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
>  kunit-objs +=                          debugfs.o
>  endif
>
> +# KUnit helpers
> +kunit-objs +=                          platform_driver.o
> +
> +# KUnit tests
>  obj-$(CONFIG_KUNIT_TEST) +=            kunit-test.o
> +obj-$(CONFIG_KUNIT_TEST) +=            platform_driver-test.o
>
>  # string-stream-test compiles built-in only.
>  ifeq ($(CONFIG_KUNIT_TEST),y)
> diff --git a/lib/kunit/platform_driver-test.c b/lib/kunit/platform_driver-test.c
> new file mode 100644
> index 000000000000..c926fe01b40a
> --- /dev/null
> +++ b/lib/kunit/platform_driver-test.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for platform driver infrastructure.
> + */
> +
> +#include <linux/platform_device.h>
> +
> +#include <kunit/platform_driver.h>
> +#include <kunit/test.h>
> +
> +/*
> + * Test that kunit_platform_device_alloc() creates a platform device.
> + */
> +static void kunit_platform_device_alloc_test(struct kunit *test)
> +{
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> +                       kunit_platform_device_alloc(test, "kunit-platform", 1));
> +}
> +
> +/*
> + * Test that kunit_platform_device_add() registers a platform device on the
> + * platform bus with the proper name and id.
> + */
> +static void kunit_platform_device_add_test(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       const char *name = "kunit-platform";
> +       const int id = -1;
> +
> +       pdev = kunit_platform_device_alloc(test, name, id);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +       KUNIT_EXPECT_EQ(test, 0, kunit_platform_device_add(test, pdev));
> +       KUNIT_EXPECT_TRUE(test, dev_is_platform(&pdev->dev));
> +       KUNIT_EXPECT_STREQ(test, pdev->name, name);
> +       KUNIT_EXPECT_EQ(test, pdev->id, id);
> +}
> +
> +static struct kunit_case kunit_platform_device_test_cases[] = {
> +       KUNIT_CASE(kunit_platform_device_alloc_test),
> +       KUNIT_CASE(kunit_platform_device_add_test),
> +       {}
> +};
> +
> +static struct kunit_suite kunit_platform_device_suite = {
> +       .name = "kunit_platform_device",
> +       .test_cases = kunit_platform_device_test_cases,
> +};
> +
> +struct kunit_platform_driver_test_context {
> +       struct platform_driver pdrv;
> +       const char *data;
> +};
> +
> +static inline struct kunit_platform_driver_test_context *
> +to_test_context(struct platform_device *pdev)
> +{
> +       return container_of(to_platform_driver(pdev->dev.driver),
> +                           struct kunit_platform_driver_test_context,
> +                           pdrv);
> +}
> +
> +static int kunit_platform_driver_probe(struct platform_device *pdev)
> +{
> +       struct kunit_platform_driver_test_context *ctx;
> +
> +       ctx = to_test_context(pdev);
> +       ctx->data = "test data";
> +
> +       return 0;
> +}
> +
> +/* Test that kunit_platform_driver_register() registers a driver that probes. */
> +static void kunit_platform_driver_register_test(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       struct kunit_platform_driver_test_context *ctx;
> +
> +       ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +
> +       pdev = kunit_platform_device_alloc(test, "kunit-platform", -1);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +       KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_add(test, pdev));
> +
> +       ctx->pdrv.probe = kunit_platform_driver_probe;
> +       ctx->pdrv.driver.name = "kunit-platform";
> +       ctx->pdrv.driver.owner = THIS_MODULE;
> +
> +       KUNIT_EXPECT_EQ(test, 0, kunit_platform_driver_register(test, &ctx->pdrv));
> +       KUNIT_EXPECT_STREQ(test, ctx->data, "test data");
> +}
> +
> +static struct kunit_case kunit_platform_driver_test_cases[] = {
> +       KUNIT_CASE(kunit_platform_driver_register_test),
> +       {}
> +};
> +
> +static struct kunit_suite kunit_platform_driver_suite = {
> +       .name = "kunit_platform_driver",
> +       .test_cases = kunit_platform_driver_test_cases,
> +};
> +
> +kunit_test_suites(&kunit_platform_device_suite,
> +                 &kunit_platform_driver_suite);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/lib/kunit/platform_driver.c b/lib/kunit/platform_driver.c
> new file mode 100644
> index 000000000000..11d155114936
> --- /dev/null
> +++ b/lib/kunit/platform_driver.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test managed platform driver
> + */
> +
> +#include <linux/device/driver.h>
> +#include <linux/platform_device.h>
> +
> +#include <kunit/resource.h>
> +
> +struct kunit_platform_device_alloc_params {
> +       const char *name;
> +       int id;
> +};

FYI: It's my plan to eventually get rid of (or at least de-emphasize)
the whole 'init' function aspect of KUnit resources so we don't need
all of these extra structs and the like. It probably won't make it in
for 6.4, but we'll see...


> +
> +static int kunit_platform_device_alloc_init(struct kunit_resource *res, void *context)
> +{
> +       struct kunit_platform_device_alloc_params *params = context;
> +       struct platform_device *pdev;
> +
> +       pdev = platform_device_alloc(params->name, params->id);
> +       if (!pdev)
> +               return -ENOMEM;
> +
> +       res->data = pdev;
> +
> +       return 0;
> +}
> +
> +static void kunit_platform_device_alloc_exit(struct kunit_resource *res)
> +{
> +       struct platform_device *pdev = res->data;
> +
> +       platform_device_put(pdev);
> +}
> +
> +/**
> + * kunit_platform_device_alloc() - Allocate a KUnit test managed platform device
> + * @test: test context
> + * @dev: platform device to alloc
> + *
> + * Register a test managed platform device. The device is put when the test completes.
> + *
> + * Returns: 0 on success, negative errno on failure.
> + */
> +struct platform_device *
> +kunit_platform_device_alloc(struct kunit *test, const char *name, int id)
> +{
> +       struct platform_device *pdev;
> +       struct kunit_platform_device_alloc_params params = {
> +               .name = name,
> +               .id = id,
> +       };
> +
> +       pdev = kunit_alloc_resource(test,
> +                                  kunit_platform_device_alloc_init,
> +                                  kunit_platform_device_alloc_exit,
> +                                  GFP_KERNEL, &params);
> +       if (!pdev)
> +               return ERR_PTR(-ENOMEM);
> +
> +       return pdev;
> +}
> +EXPORT_SYMBOL_GPL(kunit_platform_device_alloc);
> +
> +static int kunit_platform_device_add_init(struct kunit_resource *res, void *context)
> +{
> +       struct platform_device *pdev = context;
> +       int ret;
> +
> +       ret = platform_device_add(pdev);
> +       if (ret) {
> +               platform_device_put(pdev);
> +               return ret;
> +       }
> +       res->data = pdev;
> +
> +       return 0;
> +}
> +
> +static void kunit_platform_device_add_exit(struct kunit_resource *res)
> +{
> +       struct platform_device *pdev = res->data;
> +
> +       platform_device_unregister(pdev);
> +}
> +
> +/**
> + * kunit_platform_device_add() - Register a KUnit test managed platform device
> + * @test: test context
> + * @dev: platform device to add
> + *
> + * Register a test managed platform device. The device is unregistered when the
> + * test completes.
> + *
> + * Returns: 0 on success, negative errno on failure.
> + */
> +int kunit_platform_device_add(struct kunit *test, struct platform_device *pdev)
> +{
> +       struct platform_device *res;
> +
> +       res = kunit_alloc_resource(test,
> +                                  kunit_platform_device_add_init,
> +                                  kunit_platform_device_add_exit,
> +                                  GFP_KERNEL, pdev);
> +       if (!res)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(kunit_platform_device_add);
> +
> +static int kunit_platform_driver_register_init(struct kunit_resource *res, void *context)
> +{
> +       struct platform_driver *drv = context;
> +       int ret;
> +
> +       ret = platform_driver_register(drv);
> +       if (ret)
> +               return ret;
> +       res->data = drv;
> +
> +       /*
> +        * Wait for the driver to probe (or at least flush out of the deferred
> +        * workqueue)
> +        */
> +       wait_for_device_probe();
> +
> +       return 0;
> +}
> +
> +static void kunit_platform_driver_register_exit(struct kunit_resource *res)
> +{
> +       struct platform_driver *drv = res->data;
> +
> +       platform_driver_unregister(drv);
> +}
> +
> +/**
> + * kunit_platform_driver_register() - Register a KUnit test managed platform driver
> + * @test: test context
> + * @drv: platform driver to register
> + *
> + * Register a test managed platform driver. This allows callers to embed the
> + * @drv in a container structure and use container_of() in the probe function
> + * to pass information to kunit tests. It can be assumed that the driver has
> + * probed when this function returns.
> + *
> + * Example:
> + *
> + * .. code-block:: c
> + *
> + *     struct kunit_test_context {
> + *             struct platform_driver pdrv;
> + *             const char *data;
> + *     };
> + *
> + *     static inline struct kunit_test_context *
> + *     to_test_context(struct platform_device *pdev)
> + *     {
> + *             return container_of(to_platform_driver(pdev->dev.driver),
> + *                                 struct kunit_test_context,
> + *                                 pdrv);
> + *     }
> + *
> + *     static int kunit_platform_driver_probe(struct platform_device *pdev)
> + *     {
> + *             struct kunit_test_context *ctx;
> + *
> + *             ctx = to_test_context(pdev);
> + *             ctx->data = "test data";
> + *
> + *             return 0;
> + *     }
> + *
> + *     static void kunit_platform_driver_test(struct kunit *test)
> + *     {
> + *             struct kunit_test_context *ctx;
> + *
> + *             ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> + *             KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> + *
> + *             ctx->pdrv.probe = kunit_platform_driver_probe;
> + *             ctx->pdrv.driver.name = "kunit-platform";
> + *             ctx->pdrv.driver.owner = THIS_MODULE;
> + *
> + *             KUNIT_EXPECT_EQ(test, 0, kunit_platform_driver_register(test, &ctx->pdrv));
> + *             KUNIT_EXPECT_STREQ(test, ctx->data, "test data");
> + *     }
> + *
> + * Returns: 0 on success, negative errno on failure.
> + */
> +int kunit_platform_driver_register(struct kunit *test,
> +                                  struct platform_driver *drv)
> +{
> +       struct platform_driver *res;
> +
> +       res = kunit_alloc_resource(test,
> +                                  kunit_platform_driver_register_init,
> +                                  kunit_platform_driver_register_exit,
> +                                  GFP_KERNEL, drv);
> +       if (!res)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(kunit_platform_driver_register);
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
>

--000000000000a0c3e105f5f9b691
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA3
MYDU3VoxWf6GtXYoORQUAybmCeSvNNotJscWi5dJ8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMDMwNzE1NDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEASRbwOq5ugeQTH8OWBz9k
4WLqiKpXOobY5FGiblMdyCHcK1P+KPco/Y9v/JQeHqzj8BDtyZTU2jNFN69s8zqs+m2Fxnf0//b1
KZsWLfgZQ+9zWurVmDaNhTxtMKyLE9QMNsoIIAh+naRfqSD9e4c0xEe+LBDMm7N8gQctr+ihyt6R
oLUqhOHpg6WXIR5wehex6kayomfEFfFY+O1zUQsjmsQ1uPqJr+axe9MOuj+XzkmD6fy+hUT5Aw1v
fIL+ulaTTTXpNpPVlU44EBEmmy+bJVasFYH6HB4H0CXVQon4C8b4csFj3b/schA1s4izAJFXyKM8
uyvdvU7Rp8+GEgHOZg==
--000000000000a0c3e105f5f9b691--


--===============4115147407437478544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============4115147407437478544==--

