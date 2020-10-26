Return-Path: <chris.obbard@collabora.com>
Subject: Re: [PATCH] um: include compiler_attributes.h where used
References: <20201026124702.874c23068ecc.I4c3cbf992dc2c038117a01c2cd9a4c406b89ec94@changeid>
From: Christopher Obbard <chris.obbard@collabora.com>
Message-ID: <87590278-a3df-0af0-b94f-0eef2cc857c2@collabora.com>
Date: Mon, 26 Oct 2020 11:53:34 +0000
MIME-Version: 1.0
In-Reply-To: <20201026124702.874c23068ecc.I4c3cbf992dc2c038117a01c2cd9a4c406b89ec94@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Joe Perches <joe@perches.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
List-ID: <linux-um.lists.infradead.org>



On 26/10/2020 11:47, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Joe's commit didn't only convert uses of __section(...) to add
> the quotes, but _also_ converted 'raw' uses of __attribute__(())
> for setting the section to use __section, but didn't update the
> includes where necessary. Add them now.
> 
> Fixes: 33def8498fdd ("treewide: Convert macro and uses of __section(foo) to __section("foo")")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cause-identified-by: Christopher Obbard <chris.obbard@collabora.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Tested-by: Christopher Obbard <chris.obbard@collabora.com>

