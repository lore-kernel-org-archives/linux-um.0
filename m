Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1495053712.2984.5.camel@m3y3r.de>
References: <1495053712.2984.5.camel@m3y3r.de>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 21 May 2017 23:30:51 +0200
Message-ID: <CAFLxGvypP43dRGJDkMU+4OojDDrwC+7eX3uq0pH+9He6EEBfKQ@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um: Don't build arch/x86/um/user-offsets.s
 with gcc plugins
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Thomas,

On Wed, May 17, 2017 at 10:41 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> For some reasons I don't know users-offsets.s get's build before the
> gcc-plugins itself.

Can you please figure? I want to make sure that we really fix the root cause
and not just papering over a symptom.

-- 
Thanks,
//richard

