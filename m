Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4C1809D3.7030707@panasas.com>
References: <AANLkTikziSEDW07YiiJs6ny6JLhSQ-TGvdw_kTroIIx5@mail.gmail.com>
	<4C1809D3.7030707@panasas.com>
Date: Wed, 16 Jun 2010 13:27:54 +0800
Message-ID: <AANLkTikYn_EwizmUq6ZxitJ6ibCkr8Nfd4yslK_Bo0zR@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um: Include missing header file in 
	os-linux/mem.c
From: Liu Aleaxander <aleaxander@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Jun 16, 2010 at 7:16 AM, Boaz Harrosh <bharrosh@panasas.com> wrote:
> On 06/15/2010 04:06 AM, Liu Aleaxander wrote:
>> The os-linux/mem.c file calls fchmod function, which is declared in sys/stat.h
>> header file, so include it.
>>
>
> Yes. I have the same patch.
>
> Apparently it's new for Fedora 13. Previous Fedora's are compiling fine.

Same here:)

> I guess something has changed with the new gcc headers include sequence



-- 
Thanks & regards
Liu Aleaxander
