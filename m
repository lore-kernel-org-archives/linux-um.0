Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F002C7EE30
	for <linux-um@archiver.kernel.org>; Wed,  2 Jul 2025 06:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ikTVn6+s+BICvQUobxKdo14gTGNdXDACcqRcKQGtEmk=; b=ilLCnISPZFBDnbIwkzU7XZTpNI
	VijJH6maJnGGSATVx+PKKIyXxGeOS0wxJTgMPERXITwy5oxzxcdWSMkyoNEj0zIleDBh6h5hjXNSf
	40STtOaMurBQ6HzRTLx4gGmdyyz2jFwuNTEeNO2RthzA9dxCf2MppEGgl3fKjQAAPa+6WeJibZFrI
	YcArzdP7P0e5TfVIqTilnPHMMRqYWItT+cj62lqW0ZHq5wReStkFKKM3Tna8CN1QqbJ/GcKdQQLtd
	D8lMJQWUUwegRjTtw/qonrSoGdHvsjbY98D+qXbpS1fQpI+gKy4r3nhB8u3iR2TARSeEpQMSto8wJ
	BdLD6A7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWqck-00000007McN-2whm;
	Wed, 02 Jul 2025 06:07:14 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWqaa-00000007MQX-18fc
	for linux-um@lists.infradead.org;
	Wed, 02 Jul 2025 06:05:01 +0000
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so40158626d6.1
        for <linux-um@lists.infradead.org>; Tue, 01 Jul 2025 23:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751436298; x=1752041098; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ikTVn6+s+BICvQUobxKdo14gTGNdXDACcqRcKQGtEmk=;
        b=X1mec6HWb+2tBrjKzXmQbsUizTEUblncchgPXHHyPpkcvsCNkd++QLBwPTJjIxvfJ5
         3Wy3mu1p/4JPnmj0pBARgG9NUekrlvDWkpC91wsduQTAXKkTSPTDTeNychEo77LJ8EIt
         8Y73GckT/hJXVdP50VKbFup3+LO1l5Vl7o6rZpVCzWps116f7wiCM5ljNPj5zk2//Kh8
         LM7/ivsUQgMUTyxA4TGDK21vJxM0WvIGMirH6LZMCpplEHTAJDN2K406uVpFk/vkJSNU
         mPLt+R72fPutEWauT8/fTrR+CjXE2wKFpKjvgUTnpDFN32+/I9eHxzr945BsRihzcugc
         g39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751436298; x=1752041098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikTVn6+s+BICvQUobxKdo14gTGNdXDACcqRcKQGtEmk=;
        b=wMEn1c6gjunu0BEzsSgpzYCpoO8+wbBafa7CeDwf74sElum3a+mBRUp0o8Rc5poOxp
         F510a8NVi8ZVz9HcZWDMnRGEZ0Bj8BfgZKcNKgLu97Vsb00w8+WA5p36FgvqG6LNnIbN
         3EhWBSqWXrQOf+yeZ5/p50CzstX2yBYq27muqCQNcaE78/CmUELeMvIv1ejrgJEOkkWV
         O2/+q3pDKmA/qhPCS+Wg2IhffsmnK/AzSCUCbtTWHxIfrr4Ht5pU+DM7mI8tqD4EP7Wr
         ZuWLVz7IlwVzg3OGBXDvD95qEOjm8K5V9CcLeWVlzlcnAHTM9DKyaCR2edy62zgUv8Ph
         IK1w==
X-Forwarded-Encrypted: i=1; AJvYcCUF8kbLWCOL6AO/e4wfhilh/rCV29N0F9oYbx3Evd94iQ2n1S6ZAfqAralLhSHefNKhkWFKgrTF2A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0OPvpdqhR991LFhFxoR4jjLyeTMuihHbFfqTMvN4Su05pSaNs
	WhEnpCqRY+8z7mY8dfdm+7dUx6jjlbx6ARKM/dW6+IdkZCOFZTMFCf3/khBN5/1XcKyBUXajclJ
	j6tmxgJJC7G/2yi3Cwm+zqVUyu187PHYFhni5oRgz
X-Gm-Gg: ASbGncvRGP4fU3gyU1rCky3/dWBL29Q/0qrrRINm150TXYffige2dTk9agzyGQI3uD/
	lgwSjbrt88h5NaOv2QvBq83EzFnPnq564GqZulT2rkrgeVv/jM0tqPBa+Qm0R0fdn+kNTz0+x3H
	+9FpS1fsvdwZZ3lH7fTRjWQugfXyEzHPc8BtZuOmjXUdQg
X-Google-Smtp-Source: AGHT+IEARq3TAXN/dtaPML1mnXB1F0wVAtOYA4pPEff/LXIKlzhsPVg8TGtx1ERC16FKgqNY4KR2bSUh4R+r/nj6Y1A=
X-Received: by 2002:a05:6214:2343:b0:6fd:377a:a77f with SMTP id
 6a1803df08f44-702b204a849mr19332716d6.20.1751436297928; Tue, 01 Jul 2025
 23:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250626195714.2123694-1-benjamin@sipsolutions.net> <20250626195714.2123694-3-benjamin@sipsolutions.net>
In-Reply-To: <20250626195714.2123694-3-benjamin@sipsolutions.net>
From: David Gow <davidgow@google.com>
Date: Wed, 2 Jul 2025 14:04:44 +0800
X-Gm-Features: Ac12FXzDUSZmZ5IiCe1gfCp3pFCwdfVlt8Uq-SQWcMl4s09kn1uVxSxazNH_LOU
Message-ID: <CABVgOSmVtZvO1_kZgac=fsisMRmrAsv6-ZTcb4RS8d6Q+rbjxw@mail.gmail.com>
Subject: Re: [RFC 2/2] um: add a mcontext FP register handling test
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: kunit-dev@googlegroups.com, linux-um@lists.infradead.org, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Benjamin Berg <benjamin.berg@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006d6b530638ec0af0"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_230500_328214_3F51AC09 
X-CRM114-Status: GOOD (  33.94  )
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

--0000000000006d6b530638ec0af0
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 03:59, Benjamin Berg <benjamin@sipsolutions.net> wrote:
>
> From: Benjamin Berg <benjamin.berg@intel.com>
>
> This tests checks whether floating point registers are properly saved
> into the signal context and restored again. The test works by having a
> known value at the top of the FP register stack and in the first xmm
> register. Then SIGUSR1 is triggered and both of these registers are
> modified by changing the values in the mcontext.
>
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---

I really like this as an example of what we can do with UAPI tests.

Alongside the comments from Thomas, one small note below that we'd
need to put any SSE stuff behind a check for SSE support (at least on
32-bit), and skip the test.

Cheers,
-- David

>  arch/x86/um/Makefile                     |   2 +
>  arch/x86/um/tests/Makefile               |  12 +++
>  arch/x86/um/tests/registers.c            |  22 +++++
>  arch/x86/um/tests/test-fp-save-restore.c | 118 +++++++++++++++++++++++
>  4 files changed, 154 insertions(+)
>  create mode 100644 arch/x86/um/tests/Makefile
>  create mode 100644 arch/x86/um/tests/registers.c
>  create mode 100644 arch/x86/um/tests/test-fp-save-restore.c
>
> diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> index b42c31cd2390..410f5526f1f4 100644
> --- a/arch/x86/um/Makefile
> +++ b/arch/x86/um/Makefile
> @@ -15,6 +15,8 @@ obj-y = bugs_$(BITS).o delay.o fault.o \
>         sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
>         mem_$(BITS).o subarch.o os-Linux/
>
> +obj-y += tests/
> +
>  ifeq ($(CONFIG_X86_32),y)
>
>  obj-y += syscalls_32.o
> diff --git a/arch/x86/um/tests/Makefile b/arch/x86/um/tests/Makefile
> new file mode 100644
> index 000000000000..c3a868b078f3
> --- /dev/null
> +++ b/arch/x86/um/tests/Makefile
> @@ -0,0 +1,12 @@
> +include $(srctree)/init/Makefile.nolibc
> +
> +ccflags-y := -I$(obj)
> +
> +um-tests-y += registers.o
> +
> +userprogs += test-fp-save-restore
> +test-fp-save-restore-userccflags := -static $(NOLIBC_USERCFLAGS) -msse
> +
> +obj-$(CONFIG_KUNIT_UAPI) += um-tests.o
> +
> +$(obj)/registers.o: $(obj)/test-fp-save-restore
> diff --git a/arch/x86/um/tests/registers.c b/arch/x86/um/tests/registers.c
> new file mode 100644
> index 000000000000..2c4e55da043c
> --- /dev/null
> +++ b/arch/x86/um/tests/registers.c
> @@ -0,0 +1,22 @@
> +#include <kunit/test.h>
> +#include <kunit/test-bug.h>
> +#include <kunit/uapi.h>
> +
> +static void test_mcontext(struct kunit *test)
> +{
> +       KUNIT_UAPI_EMBED_BLOB(test_fp_save_restore, "test-fp-save-restore");
> +
> +       kunit_uapi_run_kselftest(test, &test_fp_save_restore);
> +}
> +
> +static struct kunit_case register_test_cases[] = {
> +       KUNIT_CASE(test_mcontext),
> +       {}
> +};
> +
> +static struct kunit_suite register_test_suite = {
> +       .name = "um_registers",
> +       .test_cases = register_test_cases,
> +};
> +
> +kunit_test_suites(&register_test_suite);
> diff --git a/arch/x86/um/tests/test-fp-save-restore.c b/arch/x86/um/tests/test-fp-save-restore.c
> new file mode 100644
> index 000000000000..28a32ca374fe
> --- /dev/null
> +++ b/arch/x86/um/tests/test-fp-save-restore.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test FP register handling in userspace mcontext.
> + *
> + * Copyright (C) 2025 Intel Corporation
> + */
> +
> +#include <math.h>
> +#include <signal.h>
> +#include <types.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys.h>
> +#include <asm/sigcontext.h>
> +#include <asm/ucontext.h>
> +
> +#include "../../../tools/testing/selftests/kselftest.h"
> +
> +#define ST0_EXP_ADD 10
> +
> +static void sighandler(int sig, siginfo_t *info, void *p)
> +{
> +       struct ucontext *uc = p;
> +       struct _fpstate *fpstate = (void *)uc->uc_mcontext.fpstate;
> +
> +       ksft_print_msg("sighandler: extended_size: %d, xstate_size: %d\n",
> +                      fpstate->sw_reserved.extended_size,
> +                      fpstate->sw_reserved.xstate_size);
> +
> +#ifdef __i386__
> +       fpstate->_st[0].exponent += ST0_EXP_ADD;
> +       fpstate->_xmm[1].element[0] |= 0x01010101;
> +       fpstate->_xmm[1].element[1] |= 0x01010101;
> +       fpstate->_xmm[1].element[2] |= 0x01010101;
> +       fpstate->_xmm[1].element[3] |= 0x01010101;
> +#else
> +       /* Hacky way of modifying the exponent without breaking aliasing */
> +       fpstate->st_space[2] += ST0_EXP_ADD;
> +       fpstate->xmm_space[4] |= 0x01010101;
> +       fpstate->xmm_space[5] |= 0x01010101;
> +       fpstate->xmm_space[6] |= 0x01010101;
> +       fpstate->xmm_space[7] |= 0x01010101;
> +#endif
> +}
> +
> +static int test_mcontext(int xmm_should_change)
> +{
> +       double num = 0.5;
> +       uint32_t sse[4] = {0x11223344, 0x55667788, 0x99aabbcc, 0xddeeff00 };
> +       long ret;
> +       int xmm_manipulated;
> +
> +       ksft_print_msg("pre-signal:  %d / 100, %08x %08x %08x %08x\n", (int) (100*num), sse[0], sse[1], sse[2], sse[3]);
> +       /*
> +        * This does kill(getpid(), SIGUSR1); with "num" being passed in AND
> +        * out of the floating point stack. We can therefore modify num by
> +        * changing st[0] when handling the signal.
> +        */
> +#ifdef __i386__

Just to ruin your day, the SSE register stuff probably needs to be
behind some check for SSE support.

> +       asm volatile (
> +               "movups %1, %%xmm1;"
> +               "int $0x80;"
> +               "movups %%xmm1, %1;"
> +               : "=t" (num), "=m" (sse), "=a" (ret)
> +               : "0" (num), "2" (__NR_kill), "b" (getpid()), "c" (SIGUSR1) :
> +               "xmm1", "memory");
> +#else
> +       asm volatile (
> +               "movups %1, %%xmm1;"
> +               "syscall;"
> +               "movups %%xmm1, %1;"
> +               : "=t" (num), "=m"(sse), "=a" (ret)
> +               : "0" (num), "2" (__NR_kill), "D" (getpid()), "S" (SIGUSR1)
> +               : "r11", "rcx", "xmm1", "memory");
> +#endif
> +       if (sse[0] == 0x11223344 || sse[1] == 0x55667788 || sse[2] == 0x99aabbcc || sse[3] == 0xddeeff00)
> +               xmm_manipulated = 0;
> +       else if (sse[0] == 0x11233345 || sse[1] == 0x55677789 || sse[2] == 0x99abbbcd || sse[3] == 0xddefff01)
> +               xmm_manipulated = 1;
> +       else
> +               xmm_manipulated = 2;
> +
> +       ksft_print_msg("post-signal: %d / 100, %08x %08x %08x %08x (should change: %d, changed: %d)\n",
> +                      (int) (100 * num), sse[0], sse[1], sse[2], sse[3], xmm_should_change, xmm_manipulated);
> +
> +       if (num != (1 << (ST0_EXP_ADD - 1))) {
> +               ksft_print_msg("floating point register was not manipulated\n");
> +               return 1;
> +       }
> +
> +       if (xmm_manipulated != xmm_should_change) {
> +               ksft_print_msg("xmm/sse had unexpected value!\n");
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
> +int main(void)
> +{
> +       struct sigaction sa = {
> +               .sa_flags = SA_SIGINFO,
> +               .sa_handler = (void (*)(int))sighandler,
> +       };
> +
> +       ksft_print_header();
> +       ksft_set_plan(1);
> +
> +       if (sys_sigaction(SIGUSR1, &sa, NULL) < 0)
> +               ksft_exit_fail_msg("Failed to register sigaction: %d\n", errno);
> +
> +       if (!test_mcontext(1))
> +               ksft_test_result_pass("mcontext\n");
> +       else
> +               ksft_test_result_fail("mcontext failed!\n");
> +
> +       ksft_finished();
> +}
> --
> 2.50.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kunit-dev/20250626195714.2123694-3-benjamin%40sipsolutions.net.

--0000000000006d6b530638ec0af0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
jmkLAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFBp5bTxrTm/d
WMmRETO8lNkA4c7fMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBF
tO3/N2l9hTaij/K0xCpLwIlrqpNo0nMAvvG5LPQQjSeHnTh06tWTgsPCOJ65GX+bqWRDwGTu8WTq
c5ihCNOikBs25j82yeLkfdbeN/tzRGUb2RD+8n9I3CnyMSG49U2s0ZdncsrIVFh47KW2TpHTF7R8
N1dri01wPg8hw4u0+XoczR2TiBrBOISKmAlkAi+P9ivT31gSHdbopoL4x0V2Ow9IOp0chrQQUZtP
KBytLhzUzd9wIsE0QMNDbw6jeG8+a4sd17zpXSbBywIGw7sEvPtnBjMaf5ib3kznlOne6tuDVx4y
QFExTCSrP3OTMUkNbpIdgzg2CHQ2aB8i8YsTZ8Q8Q8ztPJ+xDNsqBUeYxILLjTjxQQovToqipB3f
6IMyk+lWCdDS+iCLYZULV1BTHSdwp1NM3t4jZ8TMlV+JzAyRqz4lzSl8ptkFhKBJ7w2tDrZ3BEXB
8ASUByRxeh+pC1Z5/HhqfiWMVPjaWmlRRJVlRk+ObKIv2CblwxMYlo2Mn8rrbEDyfum1RTMW55Z6
Vumvw5QTHe29TYxSiusovM6OD5y0I+4zaIaYDx/AtF0mMOFXb1MDyynf1CDxhtkgnrBUseHSOU2e
MYs7IqzRap5xsgpJS+t7cp/P8fdlCNvsXss9zZa279tKwaxR0U2IzGxRGsWKGxDysn1HT6pqMDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAUXA7LnOuRz2DvkWTeMc
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgV1rVvZr3u82XKh+y9yLm9XtmEG4m
XMqTsJI0nJ8GHdYwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NzAyMDYwNDU4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAYbvn9FOA+DQjjqqFQJ/ToSsb6gJiBtHwVQeDnFelf7UFw7j1pR0cKfwuYf42NMKh
I9Kw0qT/JcdVhIOiHlgUGOuhS5irMrkzhk2S2clTuuIrAKYWVDrl09e6S8Pv3EZJCS6QQu/apWRS
Cb/SbVFJpLylAWVE7nnxDxl4fR6eQPDha8Pc6ldxuuaEuFa9IJ6/QAt1lPgp1EI6Ebol2cUqKA2i
3iTAkYsxSAzt+u38IGe2gl10nikf7afNWR6Dfats88tXzSjzD+htu7qJvWJh1Y+HsbA3K1teMjXF
CQ1qi5WCIWP/ScgCQ3C64tP3NDzb7R/lnYirKT5XKdmW0T0dkQ==
--0000000000006d6b530638ec0af0--

