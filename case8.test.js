//Test of trendingContents2...

const { graphql } = require('graphql')
const {
	makeExecutableSchema,
	addMockFunctionsToSchema,
	mockServer
} = require('graphql-tools')
const typeDefs = require('../schema/typeDefs.graphql')
const resolvers = require('../schema/resolvers')

const {
	Content
} = require('../db/models')


describe('Schema', async () => {
	const mockSchema = makeExecutableSchema({ typeDefs, resolvers })

	test('test trendingContents2', async () => {

		await Content.truncate()
		const Content1 = await Content.create({
        'id': 1,
        'source_from': 'youtube',
        'source_id': 'abcdefghi1',
        'title': 'BTS',
        'count_video': 1,
        'duration': 1,
        'channel_title': 'bts',
        'published_at': '2018-08-24 08:00:00',
        'view_count': 800})

		const Content2 = await Content.create({
        'id': 2,
        'source_from': 'youtube',
        'source_id': 'abcdefghi2',
        'title': 'BTS2',
        'count_video': 2,
        'duration': 2,
        'channel_title': 'bts',
        'published_at': '2018-08-24 08:00:00',
        'view_count': 800})

        const Content3 = await Content.create({
        'id': 3,
        'source_from': 'youtube',
        'source_id': 'abcdefghi3',
        'title': 'BTS3',
        'count_video': 3,
        'duration': 3,
        'channel_title': 'bts',
        'published_at': '2018-08-24 08:00:00',
        'view_count': 800
        })
        
        const Content4 = await Content.create({
        'id': 4,
        'source_from': 'youtube',
        'source_id': 'abcdefghi4',
        'title': 'BTS4',
        'count_video': 4,
        'duration': 4,
        'channel_title': 'bts',
        'published_at': '2018-08-24 08:00:00',
        'view_count': 800
        })

        const query = 
        `query {
            trendingContents2(first: 1) {
                pageInfo {
                    token
                    startCursor
                  }
                nodes {
                    type
                    content 
                    {
                    id
                    source_from
                    source_id
                    title
                    count_video
                    duration
                    channel_title
                    published_at
                    view_count
                    }
                }
            }
        }`
		const variables = {first: 1 }
		const context = { }
		const expected = { data: {trendingContents2: {nodes: [{
        'type': 'content',
        'content': {
        'id': 1,
        'source_from': 'youtube',
        'source_id': 'abcdefghi1',
        'title': 'BTS',
        'count_video': 1,
        'duration': 1,
        'channel_title': 'bts',
        'published_at': '2018-08-24 08:00:00',
        'view_count': 800}}]}}}

		const result = graphql(mockSchema, query, null, { }, variables)
		const rst = await expect(result).resolves
        const strCsr = rst.startCursor
        const pageToken = rst.pageToken
		delete rst.pageInfo
        await expect(result).resolves.toEqual(expected)

        // const query2 = 
        // `query() {
        //     trendingContents2(first: 2, after: 2, token: pageToken) {
        //         pageInfo {
        //             token
        //             startCursor
        //             hasNextPage
        //           }
        //         nodes {
        //             type
        //             content {
        //             id
        //             source_from
        //             source_id
        //             title
        //             count_video
        //             duration
        //             channel_title
        //             published_at
        //             view_count
        //             }
        //         }
        //     }
        // }`
        // const variables2 = {first2: 2, after: strCsr, token: pageToken }
        // const context2 = { }
        // const expected2 = {data: {searchUsers: {
        //     pageInfo: {
        //         'token': pageToken,
        //         'startCursor': strCsr,
        //         'hasNextPage': true
        //     },
        //     nodes: [
        //     {
        //         'id': 2,
        //         'source_from': 'youtube',
        //         'source_id': 'abcdefghi2',
        //         'title': 'BTS2',
        //         'count_video': 2,
        //         'duration': 2,
        //         'channel_title': 'bts',
        //         'published_at': '2018-08-24T09:00:03.000Z',
        //         'view_count': 800
        //     },
        //     {
        //         'id': 3,
        //         'source_from': 'youtube',
        //         'source_id': 'abcdefghi3',
        //         'title': 'BTS3',
        //         'count_video': 3,
        //         'duration': 3,
        //         'channel_title': 'bts',
        //         'published_at': '2018-08-24T09:00:03.000Z',
        //         'view_count': 800
        //     }]}}}
    
        //     const result2 = graphql(mockSchema, query2, null, { }, variables2)
        //     await expect(result2).resolves.toEqual(expected2)
	})
})

