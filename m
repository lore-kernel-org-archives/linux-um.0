Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CCCC48297
	for <linux-um@archiver.kernel.org>; Wed,  7 Feb 2024 00:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QJXlby+AD30AsP8JwtKyQnYYLLwLHxDqcJGOtskX1jw=; b=I6kP/CmsyW1AfTrlvp0NxVrqAC
	xypIhqD5sl3zjl3AGiYQAYSqHRTBpi/jANfwpT8wzGZuhftG7Sdt0MbKoIonGL3N0ucrqtEOxQoQy
	Z9Z/nZZwDbc3xEj5uSJzKPThQBwIp7am5ZEXdpve6xHtKwTh4f/ZOhxs69nVnAt+7p2LH9RGGTjtj
	XDXwyobQpllZkIvh3lFsfKF7m9MIKAy6riDhRdSNTr5FE0Bbt/nH2zFyuu/D20gjorjMYmoDVZ+qj
	8xvlc9dTnu5xQli4iWKJzJPJWTTJu4Ifn5W+oxzHORJ6sBDMquFh5PqmkCwiGjc3ne09iIjYwnKG/
	4rntwFTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXVrh-00000009HHY-2CvH;
	Wed, 07 Feb 2024 00:32:37 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXVre-00000009HH2-2jQQ
	for linux-um@lists.infradead.org;
	Wed, 07 Feb 2024 00:32:35 +0000
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7bed9c7d33fso3752839f.1
        for <linux-um@lists.infradead.org>; Tue, 06 Feb 2024 16:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707265950; x=1707870750; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJXlby+AD30AsP8JwtKyQnYYLLwLHxDqcJGOtskX1jw=;
        b=2TNZaziRiNGhyy4Tj+2waCTQJ1YkXCm9XqMl7F+W+uxSg44vURrxGo1lRQUGy7yafA
         VEvw19lQNz/y293Ykm1XX1WR6j6ZqvKslOYY/B7qOs7aGIFuinWVEfXZji/VjUiULF0A
         sgktZ8mbaVB6/nHa0ny1ZqHpjN5JIuclAKKNlmJssj1Z5UnEZabPdVpMkWG18ZEwtMmw
         6VzQRvSOAfRDov9T6hdouQrHee8toXY/tFPcAQX97TrUgGuSd7j36FAz3M5E6SeNmkDD
         XRgm9sqsCbyHyrAd8de79ikkMOZd9TkMgf0EU4KIYy4N+UVjut/VwER/wD5VhpKT+sxn
         UzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707265950; x=1707870750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJXlby+AD30AsP8JwtKyQnYYLLwLHxDqcJGOtskX1jw=;
        b=PhKIg2aMYu3MNWsijJU2lVjmSs+8j1gj6PDOvjfXw58/MU8Q2K1hCucwC4BRs60jSv
         trVMuxdGns/xNWzLRaL5Q8K7DDLnCCBGaBnqPABe0jZ/EqY2qIdHoZ7QQqChTJD5VaQV
         1yFDjwER4XBx89PQ4xcczMlTajw27yNJVBdAZiI/y1G94G8hox/OJV8m/mU6A4G1KrsZ
         /YMUc6hj4AB35bT0+sCUr1QFee99v44zfFr3lnkNPdr7e7JP4QMinxGRtGLzKwxIjJ8+
         UPuVy/bkLBak6SnZv17IMfKgSsHeONm+vtZVsQUMWePK8PdYlZjLHv7UgcIOwGWW71cZ
         5FDA==
X-Gm-Message-State: AOJu0YyaYE0Nj0huQsykdJWmh9BnkWnPTLT6XqtecnYRKd5JgN2rWWVL
	GtNXB8S8DsnYV1lSPNxN6K2LUPGtW/KAAp6QhC0YaE7ujYcLIhf8y4Vo+1h2+Q==
X-Google-Smtp-Source: AGHT+IFc68UeTfh18sBbRkqxKprSuedOLBwsjWYaAXb6UcbNSOYzvLEShWlSsdkoB4CHqFd0WVDn7A==
X-Received: by 2002:a6b:7b4b:0:b0:7c3:f398:7de8 with SMTP id m11-20020a6b7b4b000000b007c3f3987de8mr3414654iop.11.1707265949818;
        Tue, 06 Feb 2024 16:32:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqEC4vX8ewfaMiHobk4xS6GjGAJVg4zEGV4f2EcUVSYtvbaa7WKav90QosTXetCDOM6AK7MFFlYmnzWOVrdd9AWRh4DNgHtFbxbbQcRQGGg62wefpQmEAtz435+IlJizHzvyB1fSQFjZUAu8Ij6jhKuiMMU29qK4Xcw8xxSPG0YiQDLk5nnwaRZrQPB9FKLoIBXwo2mW9/mFypT35cHOkm1N2lrrjqxJGqqDiQU8L97onZjq58CVrmq8JdWPwAspczV9+p65+jtwNNGsJGz/HzogXLM63QHGSLsUxgt9zRpbNMofmu5rzgyzFM9tFoDLx0rleiv6bd8sk4zLRW+MPIkXu8cl3Y4YND1BBOn+ezc3Qi7K/WF1/YVkWjXWGTQWz/+D2Fpd7aLJZxJH0A9aMcX9R0OZivHReMhWiaALR0QE8iXdSvkjvN
Received: from google.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id b66-20020a0295c8000000b00470b6d256c1sm2975jai.91.2024.02.06.16.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 16:32:28 -0800 (PST)
Date: Wed, 7 Feb 2024 00:32:24 +0000
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v3 1/4] string: Redefine strscpy_pad() as a macro
Message-ID: <20240207003224.gzatchm47gy3aihv@google.com>
References: <20240206142027.make.107-kees@kernel.org>
 <20240206142221.2208763-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206142221.2208763-1-keescook@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_163234_719696_1C0DAB49 
X-CRM114-Status: GOOD (  24.98  )
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

Hi,

On Tue, Feb 06, 2024 at 06:22:16AM -0800, Kees Cook wrote:
> In preparation for making strscpy_pad()'s 3rd argument optional, redefine
> it as a macro. This also has the benefit of allowing greater FORITFY
> introspection, as it couldn't see into the strscpy() nor the memset()
> within strscpy_pad().
>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/string.h | 33 +++++++++++++++++++++++++++++++--
>  lib/string_helpers.c   | 34 ----------------------------------
>  2 files changed, 31 insertions(+), 36 deletions(-)
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index ab148d8dbfc1..03f59cf7fe72 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -70,8 +70,37 @@ extern char * strncpy(char *,const char *, __kernel_size_t);
>  ssize_t strscpy(char *, const char *, size_t);
>  #endif
>
> -/* Wraps calls to strscpy()/memset(), no arch specific code required */
> -ssize_t strscpy_pad(char *dest, const char *src, size_t count);
> +/**
> + * strscpy_pad() - Copy a C-string into a sized buffer
> + * @dest: Where to copy the string to
> + * @src: Where to copy the string from
> + * @count: Size of destination buffer
> + *
> + * Copy the string, or as much of it as fits, into the dest buffer. The
> + * behavior is undefined if the string buffers overlap. The destination
> + * buffer is always %NUL terminated, unless it's zero-sized.
> + *
> + * If the source string is shorter than the destination buffer, zeros
> + * the tail of the destination buffer.
> + *
> + * For full explanation of why you may want to consider using the
> + * 'strscpy' functions please see the function docstring for strscpy().
> + *
> + * Returns:
> + * * The number of characters copied (not including the trailing %NULs)
> + * * -E2BIG if count is 0 or @src was truncated.
> + */
> +#define strscpy_pad(dest, src, count)	({			\
> +	char *__dst = (dest);						\
> +	const char *__src = (src);					\
> +	const size_t __count = (count);					\
> +	ssize_t __wrote;						\
> +									\
> +	__wrote = strscpy(__dst, __src, __count);			\
> +	if (__wrote >= 0 && __wrote < __count)				\
> +		memset(__dst + __wrote + 1, 0, __count - __wrote - 1);	\
> +	__wrote;							\
> +})
>
>  #ifndef __HAVE_ARCH_STRCAT
>  extern char * strcat(char *, const char *);
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 7713f73e66b0..606c3099013f 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -825,40 +825,6 @@ char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n)
>  }
>  EXPORT_SYMBOL_GPL(devm_kasprintf_strarray);
>
> -/**
> - * strscpy_pad() - Copy a C-string into a sized buffer
> - * @dest: Where to copy the string to
> - * @src: Where to copy the string from
> - * @count: Size of destination buffer
> - *
> - * Copy the string, or as much of it as fits, into the dest buffer.  The
> - * behavior is undefined if the string buffers overlap.  The destination
> - * buffer is always %NUL terminated, unless it's zero-sized.
> - *
> - * If the source string is shorter than the destination buffer, zeros
> - * the tail of the destination buffer.
> - *
> - * For full explanation of why you may want to consider using the
> - * 'strscpy' functions please see the function docstring for strscpy().
> - *
> - * Returns:
> - * * The number of characters copied (not including the trailing %NUL)
> - * * -E2BIG if count is 0 or @src was truncated.
> - */
> -ssize_t strscpy_pad(char *dest, const char *src, size_t count)
> -{
> -	ssize_t written;
> -
> -	written = strscpy(dest, src, count);
> -	if (written < 0 || written == count - 1)
> -		return written;
> -
> -	memset(dest + written + 1, 0, count - written - 1);
> -
> -	return written;
> -}
> -EXPORT_SYMBOL(strscpy_pad);

Yep, looks good. This is reminiscent of strtomem and strtomem_pad.

Reviewed-by: Justin Stitt <justinstitt@google.com>

> -
>  /**
>   * skip_spaces - Removes leading whitespace from @str.
>   * @str: The string to be stripped.
> --
> 2.34.1
>

Thanks
Justin

