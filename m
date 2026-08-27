Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3049BC5DF9D
	for <linux-um@archiver.kernel.org>; Thu, 27 Aug 2026 08:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LxZheOU3heq1Rt2uci8mom6QvWxLgzl/sBJmkwWwCSE=; b=vrGnPGdsrijpYU4zdWt7PGONe8
	vHgo/mN76c0EIZA22NXFSfCO+QmVtNtJ19A8hJ+GOBj99rplItVd4N6eCewZ1ovOl6TFyNtc1Hok/
	8Ec4i72VMZFBXnJUfBSIB2SusKCEXmOC0oKSzn+qYwr7N4YkEFy+8CYQRDoG4sUMO5ag9P74fhluE
	3TwuSGZbILfPesAXPre9g4uFOrKF0xSW1TkVW+BW2zPa74UquAMgTbbD+upDcizE4sK/ykKvHn6Br
	aAo+j7o6qoB5Rg8+Z8WzBIowYfqn8qySR8CyB/fousVvFX5twTir+IbiKv4dc2FlkRuh80TXgkYRN
	KlKeh6pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzVbi-00000003eYx-07Z9;
	Thu, 27 Aug 2026 08:37:10 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzVbe-00000003eYK-3H6K
	for linux-um@lists.infradead.org;
	Thu, 27 Aug 2026 08:37:08 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso1177314a12.2
        for <linux-um@lists.infradead.org>; Thu, 27 Aug 2026 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787819825; x=1788424625; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LxZheOU3heq1Rt2uci8mom6QvWxLgzl/sBJmkwWwCSE=;
        b=lX5a2TEloNxpXefAHMMOU90MTUwubP1ssF+RnH91+GaugyFqLFzjM8FJSDgfh5sS4J
         eGp/AjJDk3NKAgrrFdBZncipXc6xN7gJcY7kEbPotEDWbjsdIR2mkyiEAZRCq/DPp4z6
         lhdIqxbcCFIX+2WpRFmGm7bfZTFa4qp6WPGFqEEXKzj9QqvZe/HGj/ZTDpDtNtBkxYuz
         5/j2zQn8ywv0F6ICpb7KpfOpXY95zwEN8n3bXMsuVeILFKaRnwVrVzIcsBp8YqM5goD6
         JtWRyAIta5hW4w9n4g+qMPndWVqJNbTLARRYrhshYUfddCdAy4vhHceuf33lQl5EbiZB
         Jq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787819825; x=1788424625;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LxZheOU3heq1Rt2uci8mom6QvWxLgzl/sBJmkwWwCSE=;
        b=hJSknUWkrNhYgOPjvxZEDch8ylLe6V495jVxrRNR829FOyvAnjHJeC7/vNncBvubSZ
         /uMfq3JiflEkVU1qUx6UzO+fccO43N64VZX8GGojQhOm3MzfOsh6sShVEZeULXqaxGH+
         CGkl/R7JwXoevuwjD5pgnGZHQRAFd48k7yEZnAZxTNqjPn5bjEDda3y1z/ymLU6u1y+I
         4qQIoOMUqKBQkI09sdpQ5M5UKhNBU3Ken5uRoU1dm25nCHo/pt1GbJhQLxSe2X/9LKta
         KLCBi+hI2emenbvxRIeRR6xLLDA2f/VP6kaxKSzvIjZOoXHPqGBtV/48YJmkhGTVvQB3
         /mAw==
X-Forwarded-Encrypted: i=1; AHgh+RpyG9rmatkYzQHXndn4IEKzeWYYA4AdY6h5H4DYs+HrgrPkUEYkOKfmnZK1/G82tvXurX8MgNvFng==@lists.infradead.org
X-Gm-Message-State: AFuF++nbadyvaAISxAjy1KUM0gwDdwr9V4/vqDHEYx7bk+JXNMu+djQa
	YKt+ce8UZBZbYjM3w9oVwTIvUiTKC5jRzFC9d6e0bbBiWAjIxUYx2Fvr
X-Gm-Gg: AR+sD11TPCSUiokFj7em7N9urCS6W6Mw2EIPIkdCJKTnqzVzjKaq9FcNUJWcJzMIVT9
	AcCwmUga+YFDM4o5uoteL8RQNaNvau5ujZG6LWWwjxLORJWvkr6hvrVQ46A3pLlW8IUfnxHFhcF
	qNy4Pt6goMdQoTeUonE1ctORJcKMHYc/5ETew5aUZ16ye35G58T082YUkOC7SdGtowbX6f/hi9+
	DWGyGeM8+oPlVDLxOl3pBT356s+RZVFqO1Zs521g+oDFqaM/vDIkk5JISWldLpAtUdCedwnzrNH
	UgThMDABX1mF1obiV5CFP+p4UC4irDGasu16ZUd4QkukEots80EmKp2GTrop784VAQtd11a5qIQ
	E49lhzlK27v/k2tneV2KwGvu2YMC25gl/2BJCcjDWyGzYQHS77rK4DwRf/6LK7z02u041FRHJCn
	c6PjLrM/dhIa52UkfeSLRs/v1Ig2i4jRabc7Mli5s0jQjUAnNPK0e+Zg02EpxijnsQN90i60dgZ
	s5yc7AnN0IXHFKyp/MlPoS6lN4ev2kjWJ17K/3uv8/W7l0jMAsGDNsxd6ts3FSt/9RSAdhZB/5b
	395hIw==
X-Received: by 2002:a05:6a21:4593:b0:3bf:9b61:f7ae with SMTP id adf61e73a8af0-3cf8413dffdmr30029671637.14.1787819825412;
        Thu, 27 Aug 2026 01:37:05 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1beae53e5sm1898674a12.7.2026.08.27.01.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 01:37:04 -0700 (PDT)
Date: Thu, 27 Aug 2026 17:36:59 +0900
Message-ID: <m2zey8ufh0.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: ljs@kernel.org
Cc: linux-mm@kvack.org,
	liam@infradead.org,
	rbm@suse.com,
	akpm@linux-foundation.org,
	luto@amacapital.net,
	brendan.jackman@linux.dev,
	david@kernel.org,
	liuhangbin@gmail.com,
	corbet@lwn.net,
	kees@kernel.org,
	broonie@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	wad@chromium.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org,
	geert@linux-m68k.org,
	daniel@thingy.jp
Subject: Re: [PATCH v2 1/2] selftests: run tests on nommu architecture
In-Reply-To: <ao2aTD1ZGObPfp4T@gremlin>
References: <20260825015945.141739-1-thehajime@gmail.com>
	<20260825015945.141739-2-thehajime@gmail.com>
	<ao2aTD1ZGObPfp4T@gremlin>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_013706_828370_04BECB58 
X-CRM114-Status: GOOD (  23.99  )
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


Hello,

On Tue, 25 Aug 2026 22:36:22 +0900,
Lorenzo Stoakes (ARM) wrote:

> > diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> > index 311811dc55a0..7287d8290b6c 100644
> > --- a/tools/testing/selftests/kselftest/runner.sh
> > +++ b/tools/testing/selftests/kselftest/runner.sh
> > @@ -38,8 +38,12 @@ tap_prefix()
> >
> >  tap_timeout()
> >  {
> > +	# nommu doesn't support timeout command (missing fork(2))
> > +	if [ "$NOMMU" = "1" ] ; then
> > +		echo "timeout isn't supported for nommu"
> > +		$1
> >  	# Make sure tests will time out if utility is available.
> > -	if [ -x /usr/bin/timeout ] ; then
> > +	elif [ -x /usr/bin/timeout ] ; then
> >  		/usr/bin/timeout --foreground "$kselftest_timeout" \
> >  			/usr/bin/timeout "$kselftest_timeout" $1
> >  	else
> > @@ -130,6 +134,7 @@ run_one()
> >  				return $KSFT_FAIL
> >  			fi
> >  		fi
> > +		OLDDIR=$(pwd)
> >  		cd `dirname $TEST` > /dev/null
> >  		(((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
> >  			tap_prefix >&4) 3>&1) |
> > @@ -147,7 +152,7 @@ run_one()
> >  		*)
> >  			ktap_test_fail "$TEST_HDR_MSG # exit=$rc";;
> >  		esac
> > -		cd - >/dev/null
> > +		cd "$OLDDIR" >/dev/null
> 
> Hmm, why are you changing this bit?

on nommu we cannot use /bin/bash (i.e., no fork(2) so, we use
/bin/hash, a busybox-offered shell with vfork.
with this `cd -` (standards specified) isn't implemented due to slim
requirement of that shell (I suppose, miserable...).

thus this workaround.

> >  	fi
> >
> >  	return $rc
> > diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> > index 261e4df94d9d..0d05946a5e7a 100644
> > --- a/tools/testing/selftests/kselftest_harness.h
> > +++ b/tools/testing/selftests/kselftest_harness.h
> > @@ -1274,6 +1274,10 @@ static int test_harness_run(int argc, char **argv)
> >  	unsigned int count = 0;
> >  	unsigned int pass_count = 0;
> >
> > +#ifdef CONFIG_NOMMU
> 
> Let's not prefix with CONFIG_ :) I think this is pretty confusing vs. the kernel
> CONFIG_xxx flags, esp. as this obviously inverts CONFIG_MMU.
> 
> maybe just 'NOMMU'?

thanks, I will remove CONFIG_ part.

initially I was trying to pull generated/autoconf.h into kselftest but
it doesn't do much compared to many modifications (run_kselftest.sh
needs to run independently from build tree) so, I used this macro but,
yes, it's confusing.

> > +	ksft_print_header();
> > +	ksft_exit_skip("kselftest harness requires fork(2), unavailable on NOMMU\n");
> > +#endif /* CONFIG_NOMMU */
> >  	ret = test_harness_argv_check(argc, argv);
> >  	if (ret != KSFT_PASS)
> >  		return ret;
> > diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> > index f02cc8a2e4ae..fdb895967768 100644
> > --- a/tools/testing/selftests/lib.mk
> > +++ b/tools/testing/selftests/lib.mk
> > @@ -97,6 +97,14 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
> >  TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
> >  TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
> >
> > +# detect if users request NOMMU build or not
> > +# User can set NOMMU to 1 to build/test for NOMMU platforms
> > +NOMMU ?= 0
> > +ifeq ($(NOMMU),1)
> > +CFLAGS += -DCONFIG_NOMMU
> > +export NOMMU
> > +endif
> > +
> 
> I wonder if this could be put into testing/selftests/nommu/something.mk? Though
> I guess would have to be included for all builds to account for nommu trying to
> build any kind of tests.

yes, in addition to moving to selftests/nommu this can be more cleaner
initial introduction of this target.

thanks for reviewing.

-- Hajime

