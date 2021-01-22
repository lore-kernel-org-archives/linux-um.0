Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2xg8-0001YF-C3
 for linux-um@lists.infradead.org; Fri, 22 Jan 2021 14:44:49 +0000
Received: by mail-lj1-x233.google.com with SMTP id f11so6764459ljm.8
 for <linux-um@lists.infradead.org>; Fri, 22 Jan 2021 06:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20210119181945.2071053-1-paullawrence@google.com>
 <m2im7pyf9s.wl-thehajime@gmail.com>
In-Reply-To: <m2im7pyf9s.wl-thehajime@gmail.com>
From: Paul Lawrence <paullawrence@google.com>
Date: Fri, 22 Jan 2021 06:44:33 -0800
Message-ID: <CAL=UVf7Umq+unpe5=EuaE=3_v6pkA6K=Bnyotgy6jyUVROow6A@mail.gmail.com>
Subject: Re: [PATCH] um: ubd: Fix crash from option parsing
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
Cc: richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, Linux kernel <linux-kernel@vger.kernel.org>, krisman@collabora.com, chris.obbard@collabora.com, anton.ivanov@cambridgegreys.com

> This was addressed/fixed by the below patch, though that one doesn't
> the first "file" variable check.

I don't believe the first file variable can in fact be NULL, so my check was
unnecessary. Pleased to see this has been fixed, we can abandon my patch now.

Paul

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

