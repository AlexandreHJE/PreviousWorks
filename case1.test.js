const { graphql } = require('graphql')
const {
	makeExecutableSchema,
	addMockFunctionsToSchema,
	mockServer
} = require('graphql-tools')
const typeDefs = require('../schema/typeDefs.graphql')
const resolvers = require('../schema/resolvers')

const {
	Content,
	Video,
	User,
} = require('../db/models')

describe('Schema', () => {
		
	const mockSchema = makeExecutableSchema({ typeDefs, resolvers })

	// Here we specify the return payloads of mocked types
	// addMockFunctionsToSchema({
	// 	schema: mockSchema,
	// 	mocks: {
	// 		Boolean: () => false,
	// 		ID: () => '1',
	// 		Int: () => 1,
	// 		Float: () => 12.34,
	// 		String: () => 'Dog',
	// 	}
	// })

	test('has valid type definitions', async () => {
		expect(async () => {
			const MockServer = mockServer(typeDefs)

			await MockServer.query(`{ __schema { types { name } } }`)
		}).not.toThrow()
	})

	test('test...', async () => {
		await User.truncate()
		const username1 = 'howard1'
		const password1 = 'asdfjiasdfjilasf'
		const user1 = await User.create({email: 'xx1@c.com', username: username1, password: password1})
		expect(user1.username).toEqual(username1)
		expect(user1.password1).not.toEqual(password1)
		const user2 = await User.create({email: 'xx2@c.com', username: 'howard2', password: 'xdddasfafsdd'})
		const user3 = await User.create({email: 'xx3@c.com', username: 'howard3', password: 'xdddasdfasdf'})
		await user1.update({feature_score: 10})

		const query = `
			query {
				featuredUsers {
				nodes {
					username
				}
				}
			}
			`
		const variables = { }
		const context = { }
		const expected = {data: {featuredUsers: {nodes: [{username: user1.username}]}} }


		return await expect(
			graphql(mockSchema, query, null, { }, variables)
		).resolves.toEqual(expected)
	})


	test('test...', async () => {
		await User.truncate()
		await User.create({email: 'xx1@c.com', username: 'howard', password: 'asdfasfasfasf'})
		await User.create({email: 'xx2@c.com', username: 'yanghoward', password: 'xdddasfafsdd'})
		await User.create({email: 'xx3@c.com', username: 'andy', password: 'xdddasdfasdf'})

		const query = `
			query($word: String!) {
				trendingSearchUsers(input: {word: $word}) {
				nodes {
					username
				}
				}
			}
			`
		const variables = {word: 'howard' }
		const context = { }
		const expected = {data: {trendingSearchUsers: {nodes: [{username: 'howard'},{username: 'yanghoward'}]}} }

		const result = graphql(mockSchema, query, null, { }, variables)
		return await expect(result).resolves.toEqual(expected)
	})


	test('test...', async () => {
		await User.truncate()
		await Content.truncate()
		await Video.truncate()

		const user1 = await User.create({email: 'xx1@c.com', username: 'howard', password: 'asdfasfasfasf'})
		const content1 = await Content.create({source_from: 'youtube', source_id: 'asfdasfasf', title: 'Taiwan'})
		const video1 = await Video.create({user_id: user1.id, content_id: content1.id, caption: 'Hi', status: 'public'})
		

		const query = `
			query($word: String!) {
				trendingSearchReactions(input: {word: $word}) {
				nodes {
					videos {
					caption
					}
				}
				}
			}
			`
		const variables = {word: 'wan' }
		const context = { }
		const expected = {data: {trendingSearchReactions: {nodes: [{videos: [{caption: 'Hi'}]}]}} }

		const result = graphql(mockSchema, query, null, { }, variables)
		await expect(result).resolves.toEqual(expected)
	})

})