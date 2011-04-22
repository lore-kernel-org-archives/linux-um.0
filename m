Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Fri, 22 Apr 2011 11:58:42 +0200
References: <20110422001050.GA468@shutemov.name>
In-Reply-To: <20110422001050.GA468@shutemov.name>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201104221158.42985.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: Adjust current_thread_info() for gcc-4.6
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Freitag 22 April 2011, 02:10:50 schrieb Kirill A. Shutemov:
> Also reproducible with gcc version 4.5.2 (Ubuntu/Linaro 4.5.2-8ubuntu4).

Interesting.
Using gcc 4.5.1 it's not reproducible.
So I've to rewrite the commit message.

Thanks,
//richard
