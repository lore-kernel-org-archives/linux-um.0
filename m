Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <98a1bff1a4cc798f0a02fd10a5f3b291c68ad1d7.camel@sipsolutions.net>
Subject: Re: [PATCH 11/30] um: Improve panic notifiers consistency and
 ordering
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 28 Apr 2022 10:30:15 +0200
In-Reply-To: <20220427224924.592546-12-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
         <20220427224924.592546-12-gpiccoli@igalia.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-kernel@vger.kernel.org, "linux-um@lists.infradead.orgAnton Ivanov" <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>
List-ID: <linux-um.lists.infradead.org>

[trimming massive CC list]

On Wed, 2022-04-27 at 19:49 -0300, Guilherme G. Piccoli wrote:
> 
> Also, we remove a useless header inclusion.

I wouldn't say it's useless, generally we try not to rely on implicit
includes so much? And you at least now use NOTIFY_DONE from it.

Otherwise looks fine to me.

johannes

