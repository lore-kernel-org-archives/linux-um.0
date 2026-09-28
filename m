Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57BDCA5FA5
	for <linux-um@archiver.kernel.org>; Mon, 28 Sep 2026 11:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1W7l83jUfjOncW8PpsfsUeV8UefI+hmLcibr0Kwb2lA=; b=0ikQzhsAHbycPT4NkYbkxR93E2
	HAhCx+219rZW2B6q2pIN+tmrW68kmf9polV/K5zIchB0qZ8AnHIJiuRaXWkvk7J3IqKJZkn41Q+y4
	O0pYp9o4SFIdjwxtdm2+FPzEjyREwKbbjlfTeE68hbBZufRUnzKRc1s4iImUB0MYTt7KoWyLtFcxX
	GWLenw8dEWYbfNypRNlHlUoaLaapKJ0suPByccj6UIPKUsg9VF/Y1GzM9LyrCx/MZN6zEsN/4Lh56
	DDRyqqqjOBMKEpBlBC1KKIntxWgXWUgGfEdKG9qHzggWZrWHHaSX3QRyVT6cnJMYbDfpIz9jtdai9
	V1ujeXIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB97t-00000000PgW-1TPQ;
	Mon, 28 Sep 2026 11:02:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB97s-00000000PgI-1iKU
	for linux-um@lists.infradead.org;
	Mon, 28 Sep 2026 11:02:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1AFD6436B3;
	Mon, 28 Sep 2026 11:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFDF1F000FF;
	Mon, 28 Sep 2026 11:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790593348;
	bh=1W7l83jUfjOncW8PpsfsUeV8UefI+hmLcibr0Kwb2lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K5xX1lShmpX9gshtl6gLw77w8dT+LjbmwtZFY8t5Dl/buHBhU/6Ohi9vnSWJUOUPd
	 rCqX9TY3Zmx1/wY2RCywDM0Pjei19fgcvxg34JLGGf4OoRIlLYf1hT73Kc9CYEijJK
	 Wedf80nHwYuvXCL/VQzZYhsTXtN/OMeqGSTMdKVFh4W6l7HhcNBXSatsIUky8RloVn
	 lPFmOTL5wdGQFLdnStZ3WYujaZ5UVqzPH/dTMPSLP1R2G9bNW3wJ3KwpbVkQoFHTn4
	 LKGsMN2V/v8UOC+lI0aouU6ethezKEqKSOEkwQkmxJx05H/r7S9WnAoQ+0LS/lZUYc
	 8VxYaWsBFWDQQ==
Date: Mon, 28 Sep 2026 12:02:19 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-mm@kvack.org, liam@infradead.org, rbm@suse.com, 
	akpm@linux-foundation.org, luto@amacapital.net, brendan.jackman@linux.dev, david@kernel.org, 
	liuhangbin@gmail.com, corbet@lwn.net, kees@kernel.org, broonie@kernel.org, 
	mhocko@suse.com, rppt@kernel.org, shuah@kernel.org, surenb@google.com, 
	vbabka@kernel.org, wad@chromium.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, geert@linux-m68k.org, 
	daniel@thingy.jp
Subject: Re: [PATCH v3 1/3] selftests: kselftest: avoid cd - in runner
Message-ID: <arpJBaUzzsLEZgDy@gremlin>
References: <20260926010819.604346-1-thehajime@gmail.com>
 <20260926010819.604346-2-thehajime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926010819.604346-2-thehajime@gmail.com>
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

On Sat, Sep 26, 2026 at 10:08:17AM +0900, Hajime Tazaki wrote:
> The kselftest runner currently uses `cd -` to restore its working
> directory after running a test.
>
> This is not supported by the minimal BusyBox hush shell used by some
> NOMMU targets. Store the original directory explicitly and restore it
> with a quoted path instead.
>
> This also avoids printing the directory change performed by `cd -` and
> handles paths containing whitespace correctly.
>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Brendan Jackman <brendan.jackman@linux.dev>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: "Ricardo B. Marliere" <rbm@suse.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>

Looks fine to me so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  tools/testing/selftests/kselftest/runner.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index 311811dc55a0..8fc1018d6fec 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -130,6 +130,7 @@ run_one()
>  				return $KSFT_FAIL
>  			fi
>  		fi
> +		OLDDIR=$(pwd)
>  		cd `dirname $TEST` > /dev/null
>  		(((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
>  			tap_prefix >&4) 3>&1) |
> @@ -147,7 +148,7 @@ run_one()
>  		*)
>  			ktap_test_fail "$TEST_HDR_MSG # exit=$rc";;
>  		esac
> -		cd - >/dev/null
> +		cd "$OLDDIR" >/dev/null
>  	fi
>
>  	return $rc
> --
> 2.43.0
>

--
Cheers, Lorenzo

